import { z } from "zod";
import { builder } from "./builder.ts";
import { requireAdult, requireViewer } from "../context.ts";
import { RedemptionRef, RewardRef } from "./types.ts";

const titleSchema = z.string().trim().min(1).max(120);

builder.mutationField("createReward", (t) =>
  t.field({
    type: RewardRef,
    authScopes: { adult: true },
    args: {
      title: t.arg.string({ required: true }),
      description: t.arg.string(),
      tokenCost: t.arg.int({ required: true }),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      const title = titleSchema.parse(args.title);
      if (args.tokenCost < 0) throw new Error("tokenCost must be ≥ 0");
      return ctx.db
        .insertInto("rewards")
        .values({
          household_id: v.householdId,
          title,
          description: args.description ?? null,
          token_cost: args.tokenCost,
          created_by_user_id: v.userId,
        })
        .returningAll()
        .executeTakeFirstOrThrow();
    },
  }),
);

builder.mutationField("updateReward", (t) =>
  t.field({
    type: RewardRef,
    authScopes: { adult: true },
    args: {
      id: t.arg({ type: "UUID", required: true }),
      title: t.arg.string(),
      description: t.arg.string(),
      tokenCost: t.arg.int(),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      const patch: Record<string, unknown> = {};
      if (args.title != null) patch.title = titleSchema.parse(args.title);
      if (args.description !== undefined) patch.description = args.description;
      if (args.tokenCost != null) {
        if (args.tokenCost < 0) throw new Error("tokenCost must be ≥ 0");
        patch.token_cost = args.tokenCost;
      }
      const updated = await ctx.db
        .updateTable("rewards")
        .set(patch)
        .where("id", "=", args.id)
        .where("household_id", "=", v.householdId)
        .returningAll()
        .executeTakeFirst();
      if (!updated) throw new Error("Reward not found");
      return updated;
    },
  }),
);

builder.mutationField("archiveReward", (t) =>
  t.field({
    type: RewardRef,
    authScopes: { adult: true },
    args: { id: t.arg({ type: "UUID", required: true }) },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      const updated = await ctx.db
        .updateTable("rewards")
        .set({ archived: true })
        .where("id", "=", args.id)
        .where("household_id", "=", v.householdId)
        .returningAll()
        .executeTakeFirst();
      if (!updated) throw new Error("Reward not found");
      return updated;
    },
  }),
);

builder.mutationField("requestRedemption", (t) =>
  t.field({
    type: RedemptionRef,
    authScopes: { authenticated: true },
    args: { rewardId: t.arg({ type: "UUID", required: true }) },
    resolve: async (_root, args, ctx) => {
      const v = requireViewer(ctx);
      return ctx.db.transaction().execute(async (trx) => {
        const reward = await trx
          .selectFrom("rewards")
          .selectAll()
          .where("id", "=", args.rewardId)
          .where("household_id", "=", v.householdId)
          .where("archived", "=", false)
          .executeTakeFirst();
        if (!reward) throw new Error("Reward not found");
        const user = await trx
          .selectFrom("users")
          .select("token_balance")
          .where("id", "=", v.userId)
          .executeTakeFirstOrThrow();
        if (user.token_balance < reward.token_cost) {
          throw new Error("Not enough tokens");
        }
        return trx
          .insertInto("redemptions")
          .values({
            reward_id: reward.id,
            user_id: v.userId,
            tokens_spent: reward.token_cost,
          })
          .returningAll()
          .executeTakeFirstOrThrow();
      });
    },
  }),
);

builder.mutationField("approveRedemption", (t) =>
  t.field({
    type: RedemptionRef,
    authScopes: { adult: true },
    args: { id: t.arg({ type: "UUID", required: true }) },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      return ctx.db.transaction().execute(async (trx) => {
        const row = await trx
          .selectFrom("redemptions as r")
          .innerJoin("rewards as rw", "rw.id", "r.reward_id")
          .where("r.id", "=", args.id)
          .where("rw.household_id", "=", v.householdId)
          .select(["r.id as r_id", "r.status as r_status", "r.user_id as r_user", "r.tokens_spent as tokens_spent"])
          .executeTakeFirst();
        if (!row) throw new Error("Redemption not found");
        if (row.r_status !== "requested") {
          throw new Error(`Cannot approve a redemption that is ${row.r_status}`);
        }

        const user = await trx
          .selectFrom("users")
          .select("token_balance")
          .where("id", "=", row.r_user)
          .executeTakeFirstOrThrow();
        if (user.token_balance < row.tokens_spent) {
          throw new Error("Child no longer has enough tokens");
        }

        const updated = await trx
          .updateTable("redemptions")
          .set({
            status: "approved",
            decided_at: new Date(),
            decided_by_user_id: v.userId,
            decision_reason: null,
          })
          .where("id", "=", args.id)
          .returningAll()
          .executeTakeFirstOrThrow();

        await trx
          .updateTable("users")
          .set((eb) => ({ token_balance: eb("token_balance", "-", row.tokens_spent) }))
          .where("id", "=", row.r_user)
          .execute();

        return updated;
      });
    },
  }),
);

builder.mutationField("denyRedemption", (t) =>
  t.field({
    type: RedemptionRef,
    authScopes: { adult: true },
    args: {
      id: t.arg({ type: "UUID", required: true }),
      reason: t.arg.string(),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      const found = await ctx.db
        .selectFrom("redemptions as r")
        .innerJoin("rewards as rw", "rw.id", "r.reward_id")
        .where("r.id", "=", args.id)
        .where("rw.household_id", "=", v.householdId)
        .select("r.id")
        .executeTakeFirst();
      if (!found) throw new Error("Redemption not found");
      return ctx.db
        .updateTable("redemptions")
        .set({
          status: "denied",
          decided_at: new Date(),
          decided_by_user_id: v.userId,
          decision_reason: args.reason ?? null,
        })
        .where("id", "=", args.id)
        .where("status", "=", "requested")
        .returningAll()
        .executeTakeFirstOrThrow();
    },
  }),
);

builder.mutationField("fulfillRedemption", (t) =>
  t.field({
    type: RedemptionRef,
    authScopes: { adult: true },
    args: { id: t.arg({ type: "UUID", required: true }) },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      const found = await ctx.db
        .selectFrom("redemptions as r")
        .innerJoin("rewards as rw", "rw.id", "r.reward_id")
        .where("r.id", "=", args.id)
        .where("rw.household_id", "=", v.householdId)
        .select(["r.id", "r.status"])
        .executeTakeFirst();
      if (!found) throw new Error("Redemption not found");
      if (found.status !== "approved") throw new Error("Approve before fulfilling");
      return ctx.db
        .updateTable("redemptions")
        .set({ status: "fulfilled" })
        .where("id", "=", args.id)
        .returningAll()
        .executeTakeFirstOrThrow();
    },
  }),
);
