import { builder } from "./builder.ts";
import { requireAdult, requireViewer } from "../context.ts";
import {
  ChoreAssignmentRef,
  ChoreRef,
  DailyQuestRef,
  HouseholdRef,
  LootDropRef,
  RedemptionRef,
  RewardRef,
  UserRef,
} from "./types.ts";
import { ChoreStatusEnum, RedemptionStatusEnum } from "./enums.ts";
import { utcDateKey } from "./loot.ts";

builder.queryField("me", (t) =>
  t.field({
    type: UserRef,
    nullable: true,
    resolve: async (_root, _args, ctx) => {
      if (!ctx.viewer) return null;
      return ctx.db
        .selectFrom("users")
        .selectAll()
        .where("id", "=", ctx.viewer.userId)
        .executeTakeFirst() ?? null;
    },
  }),
);

builder.queryField("household", (t) =>
  t.field({
    type: HouseholdRef,
    authScopes: { authenticated: true },
    resolve: async (_root, _args, ctx) => {
      const v = requireViewer(ctx);
      return ctx.db
        .selectFrom("households")
        .selectAll()
        .where("id", "=", v.householdId)
        .executeTakeFirstOrThrow();
    },
  }),
);

builder.queryField("members", (t) =>
  t.field({
    type: [UserRef],
    authScopes: { authenticated: true },
    resolve: async (_root, _args, ctx) => {
      const v = requireViewer(ctx);
      return ctx.db
        .selectFrom("users")
        .selectAll()
        .where("household_id", "=", v.householdId)
        .orderBy("role", "asc")
        .orderBy("name", "asc")
        .execute();
    },
  }),
);

builder.queryField("kidsForLogin", (t) =>
  t.field({
    type: [UserRef],
    description: "Public list of kids in a given household, for the kid login picker",
    args: {
      householdId: t.arg({ type: "UUID", required: true }),
    },
    resolve: async (_root, args, ctx) =>
      ctx.db
        .selectFrom("users")
        .selectAll()
        .where("household_id", "=", args.householdId)
        .where("role", "=", "child")
        .orderBy("name", "asc")
        .execute(),
  }),
);

builder.queryField("chores", (t) =>
  t.field({
    type: [ChoreRef],
    authScopes: { authenticated: true },
    args: {
      includeArchived: t.arg.boolean({ defaultValue: false }),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireViewer(ctx);
      let q = ctx.db
        .selectFrom("chores")
        .selectAll()
        .where("household_id", "=", v.householdId);
      if (!args.includeArchived) q = q.where("archived", "=", false);
      return q.orderBy("created_at", "desc").execute();
    },
  }),
);

builder.queryField("assignments", (t) =>
  t.field({
    type: [ChoreAssignmentRef],
    authScopes: { authenticated: true },
    args: {
      mineOnly: t.arg.boolean({ defaultValue: false }),
      status: t.arg({ type: ChoreStatusEnum }),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireViewer(ctx);
      let q = ctx.db
        .selectFrom("chore_assignments as a")
        .innerJoin("chores as c", "c.id", "a.chore_id")
        .where("c.household_id", "=", v.householdId)
        .selectAll("a");
      if (args.mineOnly || v.role === "child") {
        q = q.where("a.assigned_to_user_id", "=", v.userId);
      }
      if (args.status) q = q.where("a.status", "=", args.status);
      return q.orderBy("a.created_at", "desc").execute();
    },
  }),
);

builder.queryField("rewards", (t) =>
  t.field({
    type: [RewardRef],
    authScopes: { authenticated: true },
    args: {
      includeArchived: t.arg.boolean({ defaultValue: false }),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireViewer(ctx);
      let q = ctx.db
        .selectFrom("rewards")
        .selectAll()
        .where("household_id", "=", v.householdId);
      if (!args.includeArchived) q = q.where("archived", "=", false);
      return q.orderBy("token_cost", "asc").execute();
    },
  }),
);

builder.queryField("redemptions", (t) =>
  t.field({
    type: [RedemptionRef],
    authScopes: { authenticated: true },
    args: {
      mineOnly: t.arg.boolean({ defaultValue: false }),
      status: t.arg({ type: RedemptionStatusEnum }),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireViewer(ctx);
      let q = ctx.db
        .selectFrom("redemptions as r")
        .innerJoin("rewards as rw", "rw.id", "r.reward_id")
        .where("rw.household_id", "=", v.householdId)
        .selectAll("r");
      if (args.mineOnly || v.role === "child") {
        q = q.where("r.user_id", "=", v.userId);
      }
      if (args.status) q = q.where("r.status", "=", args.status);
      return q.orderBy("r.requested_at", "desc").execute();
    },
  }),
);

builder.queryField("pendingApprovals", (t) =>
  t.field({
    type: [ChoreAssignmentRef],
    authScopes: { adult: true },
    resolve: async (_root, _args, ctx) => {
      const v = requireAdult(ctx);
      return ctx.db
        .selectFrom("chore_assignments as a")
        .innerJoin("chores as c", "c.id", "a.chore_id")
        .where("c.household_id", "=", v.householdId)
        .where("a.status", "=", "submitted")
        .selectAll("a")
        .orderBy("a.submitted_at", "asc")
        .execute();
    },
  }),
);

builder.queryField("pendingRedemptions", (t) =>
  t.field({
    type: [RedemptionRef],
    authScopes: { adult: true },
    resolve: async (_root, _args, ctx) => {
      const v = requireAdult(ctx);
      return ctx.db
        .selectFrom("redemptions as r")
        .innerJoin("rewards as rw", "rw.id", "r.reward_id")
        .where("rw.household_id", "=", v.householdId)
        .where("r.status", "=", "requested")
        .selectAll("r")
        .orderBy("r.requested_at", "asc")
        .execute();
    },
  }),
);

builder.queryField("leaderboard", (t) =>
  t.field({
    type: [UserRef],
    authScopes: { authenticated: true },
    resolve: async (_root, _args, ctx) => {
      const v = requireViewer(ctx);
      return ctx.db
        .selectFrom("users")
        .selectAll()
        .where("household_id", "=", v.householdId)
        .where("role", "=", "child")
        .orderBy("token_balance", "desc")
        .execute();
    },
  }),
);

builder.queryField("todayQuest", (t) =>
  t.field({
    type: DailyQuestRef,
    authScopes: { authenticated: true },
    description: "The viewer's daily-quest row for today (UTC). Lazily created when first inspected.",
    resolve: async (_root, _args, ctx) => {
      const v = requireViewer(ctx);
      const today = utcDateKey();
      const existing = await ctx.db
        .selectFrom("user_daily_quests")
        .selectAll()
        .where("user_id", "=", v.userId)
        .where("quest_date", "=", today)
        .executeTakeFirst();
      if (existing) return existing;
      return ctx.db
        .insertInto("user_daily_quests")
        .values({
          user_id: v.userId,
          quest_date: today,
          goal: 3,
          progress: 0,
        })
        .returningAll()
        .executeTakeFirstOrThrow();
    },
  }),
);

builder.queryField("myLootDrops", (t) =>
  t.field({
    type: [LootDropRef],
    authScopes: { authenticated: true },
    args: {
      limit: t.arg.int({ defaultValue: 50 }),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireViewer(ctx);
      const limit = Math.min(Math.max(args.limit ?? 50, 1), 200);
      return ctx.db
        .selectFrom("loot_drops")
        .selectAll()
        .where("user_id", "=", v.userId)
        .where("status", "in", ["pending", "committed"])
        .orderBy("created_at", "desc")
        .limit(limit)
        .execute();
    },
  }),
);
