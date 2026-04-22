import type { Selectable } from "kysely";
import { builder } from "./builder.ts";
import type {
  ChoreAssignments,
  Chores,
  Households,
  LootDrops,
  Redemptions,
  Rewards,
  UserDailyQuests,
  Users,
} from "../db/generated.ts";
import {
  ChoreStatusEnum,
  LootDropStatusEnum,
  LootRarityEnum,
  RecurrenceEnum,
  RedemptionStatusEnum,
  RoleEnum,
} from "./enums.ts";
import { xpToLevel } from "./loot.ts";

export type HouseholdRow = Selectable<Households>;
export type UserRow = Selectable<Users>;
export type ChoreRow = Selectable<Chores>;
export type AssignmentRow = Selectable<ChoreAssignments>;
export type RewardRow = Selectable<Rewards>;
export type RedemptionRow = Selectable<Redemptions>;
export type LootDropRow = Selectable<LootDrops>;
export type DailyQuestRow = Selectable<UserDailyQuests>;

export const HouseholdRef = builder.objectRef<HouseholdRow>("Household").implement({
  fields: (t) => ({
    id: t.exposeID("id"),
    name: t.exposeString("name"),
    createdAt: t.field({ type: "DateTime", resolve: (h) => h.created_at }),
  }),
});

export const UserRef = builder.objectRef<UserRow>("User").implement({
  fields: (t) => ({
    id: t.exposeID("id"),
    householdId: t.field({ type: "UUID", resolve: (u) => u.household_id }),
    name: t.exposeString("name"),
    role: t.field({ type: RoleEnum, resolve: (u) => u.role }),
    avatarEmoji: t.exposeString("avatar_emoji"),
    tokenBalance: t.exposeInt("token_balance"),
    xp: t.exposeInt("xp"),
    level: t.int({ resolve: (u) => xpToLevel(u.xp).level }),
    xpIntoLevel: t.int({ resolve: (u) => xpToLevel(u.xp).xpIntoLevel }),
    xpForNextLevel: t.int({ resolve: (u) => xpToLevel(u.xp).xpForNext }),
    streakDays: t.exposeInt("streak_days"),
    streakLastDate: t.field({
      type: "DateTime",
      nullable: true,
      resolve: (u) => u.streak_last_date,
    }),
    email: t.exposeString("email", { nullable: true }),
    createdAt: t.field({ type: "DateTime", resolve: (u) => u.created_at }),
  }),
});

export const ChoreRef = builder.objectRef<ChoreRow>("Chore").implement({
  fields: (t) => ({
    id: t.exposeID("id"),
    title: t.exposeString("title"),
    description: t.exposeString("description", { nullable: true }),
    tokenValue: t.exposeInt("token_value"),
    xpValue: t.exposeInt("xp_value"),
    recurrence: t.field({ type: RecurrenceEnum, resolve: (c) => c.recurrence }),
    archived: t.exposeBoolean("archived"),
    createdAt: t.field({ type: "DateTime", resolve: (c) => c.created_at }),
    createdBy: t.field({
      type: UserRef,
      resolve: async (c, _args, ctx) =>
        ctx.db
          .selectFrom("users")
          .selectAll()
          .where("id", "=", c.created_by_user_id)
          .executeTakeFirstOrThrow(),
    }),
  }),
});

export const ChoreAssignmentRef = builder
  .objectRef<AssignmentRow>("ChoreAssignment")
  .implement({
    fields: (t) => ({
      id: t.exposeID("id"),
      status: t.field({ type: ChoreStatusEnum, resolve: (a) => a.status }),
      dueDate: t.field({
        type: "DateTime",
        nullable: true,
        resolve: (a) => a.due_date,
      }),
      submittedAt: t.field({
        type: "DateTime",
        nullable: true,
        resolve: (a) => a.submitted_at,
      }),
      approvedAt: t.field({
        type: "DateTime",
        nullable: true,
        resolve: (a) => a.approved_at,
      }),
      rejectReason: t.exposeString("reject_reason", { nullable: true }),
      createdAt: t.field({ type: "DateTime", resolve: (a) => a.created_at }),
      combo: t.int({
        description:
          "The combo count that will be recorded if/when this assignment is approved. For already-approved assignments, returns the snapshot taken at approval.",
        resolve: async (a, _args, ctx) => {
          if (a.status === "approved") return a.combo_at_approval ?? 1;
          const row = await ctx.db
            .selectFrom("chore_user_combos")
            .select(["current_combo", "last_approved_at"])
            .where("chore_id", "=", a.chore_id)
            .where("user_id", "=", a.assigned_to_user_id)
            .executeTakeFirst();
          if (!row || row.current_combo <= 0 || !row.last_approved_at) return 1;
          return row.current_combo + 1;
        },
      }),
      chore: t.field({
        type: ChoreRef,
        resolve: async (a, _args, ctx) =>
          ctx.db
            .selectFrom("chores")
            .selectAll()
            .where("id", "=", a.chore_id)
            .executeTakeFirstOrThrow(),
      }),
      assignedTo: t.field({
        type: UserRef,
        resolve: async (a, _args, ctx) =>
          ctx.db
            .selectFrom("users")
            .selectAll()
            .where("id", "=", a.assigned_to_user_id)
            .executeTakeFirstOrThrow(),
      }),
    }),
  });

export const RewardRef = builder.objectRef<RewardRow>("Reward").implement({
  fields: (t) => ({
    id: t.exposeID("id"),
    title: t.exposeString("title"),
    description: t.exposeString("description", { nullable: true }),
    tokenCost: t.exposeInt("token_cost"),
    archived: t.exposeBoolean("archived"),
    createdAt: t.field({ type: "DateTime", resolve: (r) => r.created_at }),
  }),
});

export const RedemptionRef = builder.objectRef<RedemptionRow>("Redemption").implement({
  fields: (t) => ({
    id: t.exposeID("id"),
    status: t.field({ type: RedemptionStatusEnum, resolve: (r) => r.status }),
    tokensSpent: t.exposeInt("tokens_spent"),
    requestedAt: t.field({ type: "DateTime", resolve: (r) => r.requested_at }),
    decidedAt: t.field({
      type: "DateTime",
      nullable: true,
      resolve: (r) => r.decided_at,
    }),
    decisionReason: t.exposeString("decision_reason", { nullable: true }),
    reward: t.field({
      type: RewardRef,
      resolve: async (r, _args, ctx) =>
        ctx.db
          .selectFrom("rewards")
          .selectAll()
          .where("id", "=", r.reward_id)
          .executeTakeFirstOrThrow(),
    }),
    user: t.field({
      type: UserRef,
      resolve: async (r, _args, ctx) =>
        ctx.db
          .selectFrom("users")
          .selectAll()
          .where("id", "=", r.user_id)
          .executeTakeFirstOrThrow(),
    }),
  }),
});

export const LootDropRef = builder.objectRef<LootDropRow>("LootDrop").implement({
  fields: (t) => ({
    id: t.exposeID("id"),
    rarity: t.field({ type: LootRarityEnum, resolve: (d) => d.rarity }),
    status: t.field({ type: LootDropStatusEnum, resolve: (d) => d.status }),
    isQuestBonus: t.exposeBoolean("is_quest_bonus"),
    itemEmoji: t.exposeString("item_emoji"),
    itemLabel: t.exposeString("item_label"),
    itemDescription: t.exposeString("item_description"),
    createdAt: t.field({ type: "DateTime", resolve: (d) => d.created_at }),
    committedAt: t.field({
      type: "DateTime",
      nullable: true,
      resolve: (d) => d.committed_at,
    }),
    assignmentId: t.field({
      type: "UUID",
      nullable: true,
      resolve: (d) => d.assignment_id,
    }),
  }),
});

export const DailyQuestRef = builder.objectRef<DailyQuestRow>("DailyQuest").implement({
  fields: (t) => ({
    id: t.exposeID("id"),
    questDate: t.field({ type: "DateTime", resolve: (q) => q.quest_date }),
    goal: t.exposeInt("goal"),
    progress: t.exposeInt("progress"),
    rewardClaimedAt: t.field({
      type: "DateTime",
      nullable: true,
      resolve: (q) => q.reward_claimed_at,
    }),
    rewardDrop: t.field({
      type: LootDropRef,
      nullable: true,
      resolve: async (q, _args, ctx) => {
        if (!q.reward_drop_id) return null;
        return ctx.db
          .selectFrom("loot_drops")
          .selectAll()
          .where("id", "=", q.reward_drop_id)
          .executeTakeFirst() ?? null;
      },
    }),
  }),
});

export type SubmitChorePayload = { assignment: AssignmentRow; lootDrop: LootDropRow };

export const SubmitChorePayloadRef = builder
  .objectRef<SubmitChorePayload>("SubmitChorePayload")
  .implement({
    fields: (t) => ({
      assignment: t.field({ type: ChoreAssignmentRef, resolve: (p) => p.assignment }),
      lootDrop: t.field({ type: LootDropRef, resolve: (p) => p.lootDrop }),
    }),
  });

export type ApproveChorePayload = {
  assignment: AssignmentRow;
  lootDrop: LootDropRow | null;
  questBonus: LootDropRow | null;
  quest: DailyQuestRow;
  user: UserRow;
};

export const ApproveChorePayloadRef = builder
  .objectRef<ApproveChorePayload>("ApproveChorePayload")
  .implement({
    fields: (t) => ({
      assignment: t.field({ type: ChoreAssignmentRef, resolve: (p) => p.assignment }),
      lootDrop: t.field({
        type: LootDropRef,
        nullable: true,
        resolve: (p) => p.lootDrop,
      }),
      questBonus: t.field({
        type: LootDropRef,
        nullable: true,
        resolve: (p) => p.questBonus,
      }),
      quest: t.field({ type: DailyQuestRef, resolve: (p) => p.quest }),
      user: t.field({ type: UserRef, resolve: (p) => p.user }),
    }),
  });

export const AuthPayloadRef = builder
  .objectRef<{ token: string; user: UserRow }>("AuthPayload")
  .implement({
    fields: (t) => ({
      token: t.exposeString("token"),
      user: t.field({ type: UserRef, resolve: (p) => p.user }),
    }),
  });
