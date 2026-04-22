import { z } from "zod";
import { builder } from "./builder.ts";
import { requireAdult, requireViewer } from "../context.ts";
import {
  ApproveChorePayloadRef,
  ChoreAssignmentRef,
  ChoreRef,
  SubmitChorePayloadRef,
} from "./types.ts";
import { RecurrenceEnum } from "./enums.ts";
import { pickItem, rollRarity, utcDateKey, utcDayDiff } from "./loot.ts";

const titleSchema = z.string().trim().min(1).max(120);

builder.mutationField("createChore", (t) =>
  t.field({
    type: ChoreRef,
    authScopes: { adult: true },
    args: {
      title: t.arg.string({ required: true }),
      description: t.arg.string(),
      tokenValue: t.arg.int({ required: true }),
      xpValue: t.arg.int(),
      recurrence: t.arg({ type: RecurrenceEnum, defaultValue: "one_off" }),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      const title = titleSchema.parse(args.title);
      if (args.tokenValue < 0) throw new Error("tokenValue must be ≥ 0");
      if (args.xpValue != null && args.xpValue < 0) throw new Error("xpValue must be ≥ 0");
      return ctx.db
        .insertInto("chores")
        .values({
          household_id: v.householdId,
          title,
          description: args.description ?? null,
          token_value: args.tokenValue,
          xp_value: args.xpValue ?? defaultXpForTokens(args.tokenValue),
          recurrence: args.recurrence ?? "one_off",
          created_by_user_id: v.userId,
        })
        .returningAll()
        .executeTakeFirstOrThrow();
    },
  }),
);

builder.mutationField("updateChore", (t) =>
  t.field({
    type: ChoreRef,
    authScopes: { adult: true },
    args: {
      id: t.arg({ type: "UUID", required: true }),
      title: t.arg.string(),
      description: t.arg.string(),
      tokenValue: t.arg.int(),
      xpValue: t.arg.int(),
      recurrence: t.arg({ type: RecurrenceEnum }),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      const patch: Record<string, unknown> = {};
      if (args.title != null) patch.title = titleSchema.parse(args.title);
      if (args.description !== undefined) patch.description = args.description;
      if (args.tokenValue != null) {
        if (args.tokenValue < 0) throw new Error("tokenValue must be ≥ 0");
        patch.token_value = args.tokenValue;
      }
      if (args.xpValue != null) {
        if (args.xpValue < 0) throw new Error("xpValue must be ≥ 0");
        patch.xp_value = args.xpValue;
      }
      if (args.recurrence != null) patch.recurrence = args.recurrence;
      const updated = await ctx.db
        .updateTable("chores")
        .set(patch)
        .where("id", "=", args.id)
        .where("household_id", "=", v.householdId)
        .returningAll()
        .executeTakeFirst();
      if (!updated) throw new Error("Chore not found");
      return updated;
    },
  }),
);

builder.mutationField("archiveChore", (t) =>
  t.field({
    type: ChoreRef,
    authScopes: { adult: true },
    args: { id: t.arg({ type: "UUID", required: true }) },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      const updated = await ctx.db
        .updateTable("chores")
        .set({ archived: true })
        .where("id", "=", args.id)
        .where("household_id", "=", v.householdId)
        .returningAll()
        .executeTakeFirst();
      if (!updated) throw new Error("Chore not found");
      return updated;
    },
  }),
);

builder.mutationField("assignChore", (t) =>
  t.field({
    type: ChoreAssignmentRef,
    authScopes: { adult: true },
    args: {
      choreId: t.arg({ type: "UUID", required: true }),
      assignedToUserId: t.arg({ type: "UUID", required: true }),
      dueDate: t.arg({ type: "DateTime" }),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      const chore = await ctx.db
        .selectFrom("chores")
        .select("id")
        .where("id", "=", args.choreId)
        .where("household_id", "=", v.householdId)
        .executeTakeFirst();
      if (!chore) throw new Error("Chore not in your household");
      const target = await ctx.db
        .selectFrom("users")
        .select("id")
        .where("id", "=", args.assignedToUserId)
        .where("household_id", "=", v.householdId)
        .executeTakeFirst();
      if (!target) throw new Error("User not in your household");

      return ctx.db
        .insertInto("chore_assignments")
        .values({
          chore_id: args.choreId,
          assigned_to_user_id: args.assignedToUserId,
          due_date: args.dueDate ?? null,
        })
        .returningAll()
        .executeTakeFirstOrThrow();
    },
  }),
);

builder.mutationField("submitChore", (t) =>
  t.field({
    type: SubmitChorePayloadRef,
    authScopes: { authenticated: true },
    args: { assignmentId: t.arg({ type: "UUID", required: true }) },
    resolve: async (_root, args, ctx) => {
      const v = requireViewer(ctx);
      return ctx.db.transaction().execute(async (trx) => {
        const assignment = await trx
          .selectFrom("chore_assignments as a")
          .innerJoin("chores as c", "c.id", "a.chore_id")
          .where("a.id", "=", args.assignmentId)
          .where("c.household_id", "=", v.householdId)
          .selectAll("a")
          .executeTakeFirst();
        if (!assignment) throw new Error("Assignment not found");
        if (
          v.role === "child" &&
          assignment.assigned_to_user_id !== v.userId
        ) {
          throw new Error("Not your chore");
        }
        if (
          assignment.status !== "pending" &&
          assignment.status !== "rejected"
        ) {
          throw new Error(`Cannot submit a chore that is ${assignment.status}`);
        }

        const updated = await trx
          .updateTable("chore_assignments")
          .set({
            status: "submitted",
            submitted_at: new Date(),
            reject_reason: null,
          })
          .where("id", "=", args.assignmentId)
          .returningAll()
          .executeTakeFirstOrThrow();

        // Void any previous pending drops for this assignment (e.g. after
        // a reject→resubmit cycle).
        await trx
          .updateTable("loot_drops")
          .set({ status: "voided" })
          .where("assignment_id", "=", args.assignmentId)
          .where("status", "=", "pending")
          .execute();

        const rarity = rollRarity({ boosted: false });
        const item = pickItem(rarity);
        const drop = await trx
          .insertInto("loot_drops")
          .values({
            user_id: assignment.assigned_to_user_id,
            assignment_id: assignment.id,
            rarity,
            status: "pending",
            is_quest_bonus: false,
            item_emoji: item.emoji,
            item_label: item.label,
            item_description: item.description,
          })
          .returningAll()
          .executeTakeFirstOrThrow();

        return { assignment: updated, lootDrop: drop };
      });
    },
  }),
);

builder.mutationField("approveChore", (t) =>
  t.field({
    type: ApproveChorePayloadRef,
    authScopes: { adult: true },
    args: { assignmentId: t.arg({ type: "UUID", required: true }) },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      return ctx.db.transaction().execute(async (trx) => {
        const row = await trx
          .selectFrom("chore_assignments as a")
          .innerJoin("chores as c", "c.id", "a.chore_id")
          .where("a.id", "=", args.assignmentId)
          .where("c.household_id", "=", v.householdId)
          .select([
            "a.id as a_id",
            "a.status as a_status",
            "a.assigned_to_user_id as a_user",
            "a.due_date as a_due_date",
            "a.chore_id as a_chore_id",
            "c.token_value as token_value",
            "c.xp_value as xp_value",
            "c.recurrence as recurrence",
            "c.archived as archived",
          ])
          .executeTakeFirst();
        if (!row) throw new Error("Assignment not found");
        if (row.a_status === "approved") throw new Error("Already approved");

        const now = new Date();

        // ---- Combo ----------------------------------------------------
        const prevCombo = await trx
          .selectFrom("chore_user_combos")
          .select(["current_combo", "last_approved_at"])
          .where("chore_id", "=", row.a_chore_id)
          .where("user_id", "=", row.a_user)
          .executeTakeFirst();

        let nextCombo = 1;
        if (prevCombo && prevCombo.last_approved_at) {
          const diff = utcDayDiff(now, prevCombo.last_approved_at);
          const windowOk =
            row.recurrence === "daily"
              ? diff >= 1 && diff <= 2
              : row.recurrence === "weekly"
              ? diff >= 5 && diff <= 9
              : diff <= 2;
          if (windowOk) nextCombo = prevCombo.current_combo + 1;
        }

        await trx
          .insertInto("chore_user_combos")
          .values({
            chore_id: row.a_chore_id,
            user_id: row.a_user,
            current_combo: nextCombo,
            last_approved_at: now,
            updated_at: now,
          })
          .onConflict((oc) =>
            oc.columns(["chore_id", "user_id"]).doUpdateSet({
              current_combo: nextCombo,
              last_approved_at: now,
              updated_at: now,
            }),
          )
          .execute();

        // ---- Assignment status ---------------------------------------
        const updatedAssignment = await trx
          .updateTable("chore_assignments")
          .set({
            status: "approved",
            approved_at: now,
            approved_by_user_id: v.userId,
            combo_at_approval: nextCombo,
            reject_reason: null,
          })
          .where("id", "=", args.assignmentId)
          .returningAll()
          .executeTakeFirstOrThrow();

        // ---- Tokens + XP + streak -----------------------------------
        const today = utcDateKey(now);

        const userBefore = await trx
          .selectFrom("users")
          .select(["xp", "streak_days", "streak_last_date"])
          .where("id", "=", row.a_user)
          .executeTakeFirstOrThrow();

        let nextStreak: number;
        const lastStreakDate = userBefore.streak_last_date;
        if (!lastStreakDate) {
          nextStreak = 1;
        } else {
          const diff = utcDayDiff(now, lastStreakDate);
          if (diff === 0) {
            nextStreak = userBefore.streak_days;
          } else if (diff === 1) {
            nextStreak = userBefore.streak_days + 1;
          } else {
            nextStreak = 1;
          }
        }

        const updatedUser = await trx
          .updateTable("users")
          .set((eb) => ({
            token_balance: eb("token_balance", "+", row.token_value),
            xp: eb("xp", "+", row.xp_value),
            streak_days: nextStreak,
            streak_last_date: now,
          }))
          .where("id", "=", row.a_user)
          .returningAll()
          .executeTakeFirstOrThrow();

        // ---- Commit the pending loot drop from submit ---------------
        let lootDrop = await trx
          .updateTable("loot_drops")
          .set({ status: "committed", committed_at: now })
          .where("assignment_id", "=", args.assignmentId)
          .where("status", "=", "pending")
          .returningAll()
          .executeTakeFirst();
        if (!lootDrop) {
          // No pending drop (e.g. approval of an assignment that was never
          // "submitted" — adult credited directly). Roll one now.
          const rarity = rollRarity({ boosted: false });
          const item = pickItem(rarity);
          lootDrop = await trx
            .insertInto("loot_drops")
            .values({
              user_id: row.a_user,
              assignment_id: row.a_id,
              rarity,
              status: "committed",
              committed_at: now,
              is_quest_bonus: false,
              item_emoji: item.emoji,
              item_label: item.label,
              item_description: item.description,
            })
            .returningAll()
            .executeTakeFirstOrThrow();
        }

        // ---- Daily quest progress + bonus ---------------------------
        const existingQuest = await trx
          .selectFrom("user_daily_quests")
          .selectAll()
          .where("user_id", "=", row.a_user)
          .where("quest_date", "=", today)
          .executeTakeFirst();

        let quest = existingQuest;
        if (!quest) {
          quest = await trx
            .insertInto("user_daily_quests")
            .values({
              user_id: row.a_user,
              quest_date: today,
              goal: 3,
              progress: 1,
            })
            .returningAll()
            .executeTakeFirstOrThrow();
        } else {
          quest = await trx
            .updateTable("user_daily_quests")
            .set((eb) => ({ progress: eb("progress", "+", 1) }))
            .where("id", "=", quest.id)
            .returningAll()
            .executeTakeFirstOrThrow();
        }

        let questBonus: typeof lootDrop | null = null;
        if (quest.progress >= quest.goal && !quest.reward_claimed_at) {
          const rarity = rollRarity({ boosted: true });
          const item = pickItem(rarity);
          questBonus = await trx
            .insertInto("loot_drops")
            .values({
              user_id: row.a_user,
              assignment_id: null,
              rarity,
              status: "committed",
              committed_at: now,
              is_quest_bonus: true,
              item_emoji: item.emoji,
              item_label: item.label,
              item_description: item.description,
            })
            .returningAll()
            .executeTakeFirstOrThrow();
          quest = await trx
            .updateTable("user_daily_quests")
            .set({ reward_claimed_at: now, reward_drop_id: questBonus.id })
            .where("id", "=", quest.id)
            .returningAll()
            .executeTakeFirstOrThrow();
        }

        // ---- Auto-spawn next recurring assignment -------------------
        if (!row.archived && row.recurrence !== "one_off") {
          const base = row.a_due_date ?? now;
          const nextDue = new Date(base);
          if (row.recurrence === "daily") nextDue.setDate(nextDue.getDate() + 1);
          if (row.recurrence === "weekly") nextDue.setDate(nextDue.getDate() + 7);
          const dup = await trx
            .selectFrom("chore_assignments")
            .select("id")
            .where("chore_id", "=", row.a_chore_id)
            .where("assigned_to_user_id", "=", row.a_user)
            .where("status", "in", ["pending", "submitted", "rejected"])
            .executeTakeFirst();
          if (!dup) {
            await trx
              .insertInto("chore_assignments")
              .values({
                chore_id: row.a_chore_id,
                assigned_to_user_id: row.a_user,
                due_date: nextDue,
              })
              .execute();
          }
        }

        return {
          assignment: updatedAssignment,
          lootDrop,
          questBonus,
          quest,
          user: updatedUser,
        };
      });
    },
  }),
);

builder.mutationField("rejectChore", (t) =>
  t.field({
    type: ChoreAssignmentRef,
    authScopes: { adult: true },
    args: {
      assignmentId: t.arg({ type: "UUID", required: true }),
      reason: t.arg.string(),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      return ctx.db.transaction().execute(async (trx) => {
        const found = await trx
          .selectFrom("chore_assignments as a")
          .innerJoin("chores as c", "c.id", "a.chore_id")
          .where("a.id", "=", args.assignmentId)
          .where("c.household_id", "=", v.householdId)
          .select("a.id")
          .executeTakeFirst();
        if (!found) throw new Error("Assignment not found");

        // Void any pending drop from the kid's submit — they don't keep it.
        await trx
          .updateTable("loot_drops")
          .set({ status: "voided" })
          .where("assignment_id", "=", args.assignmentId)
          .where("status", "=", "pending")
          .execute();

        return trx
          .updateTable("chore_assignments")
          .set({
            status: "rejected",
            reject_reason: args.reason ?? null,
            submitted_at: null,
          })
          .where("id", "=", args.assignmentId)
          .returningAll()
          .executeTakeFirstOrThrow();
      });
    },
  }),
);

/** Sensible default: ~4 XP per token so leveling roughly tracks tokens. */
function defaultXpForTokens(tokens: number): number {
  return tokens * 4;
}
