import { z } from "zod";
import { builder } from "./builder.ts";
import { requireAdult, requireViewer } from "../context.ts";
import { ChoreAssignmentRef, ChoreRef } from "./types.ts";
import { ChoreKindEnum, RecurrenceEnum } from "./enums.ts";

const titleSchema = z.string().trim().min(1).max(120);

builder.mutationField("createChore", (t) =>
  t.field({
    type: ChoreRef,
    authScopes: { adult: true },
    args: {
      title: t.arg.string({ required: true }),
      description: t.arg.string(),
      tokenValue: t.arg.int({ required: true }),
      kind: t.arg({ type: ChoreKindEnum, defaultValue: "scheduled" }),
      recurrence: t.arg({ type: RecurrenceEnum, defaultValue: "one_off" }),
      cooldownMinutes: t.arg.int({ defaultValue: 0 }),
    },
    resolve: async (_root, args, ctx) => {
      const v = requireAdult(ctx);
      const title = titleSchema.parse(args.title);
      if (args.tokenValue < 0) throw new Error("tokenValue must be ≥ 0");
      const cooldown = args.cooldownMinutes ?? 0;
      if (cooldown < 0) throw new Error("cooldownMinutes must be ≥ 0");
      return ctx.db
        .insertInto("chores")
        .values({
          household_id: v.householdId,
          title,
          description: args.description ?? null,
          token_value: args.tokenValue,
          kind: args.kind ?? "scheduled",
          recurrence: args.recurrence ?? "one_off",
          cooldown_minutes: cooldown,
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
      kind: t.arg({ type: ChoreKindEnum }),
      recurrence: t.arg({ type: RecurrenceEnum }),
      cooldownMinutes: t.arg.int(),
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
      if (args.kind != null) patch.kind = args.kind;
      if (args.recurrence != null) patch.recurrence = args.recurrence;
      if (args.cooldownMinutes != null) {
        if (args.cooldownMinutes < 0) throw new Error("cooldownMinutes must be ≥ 0");
        patch.cooldown_minutes = args.cooldownMinutes;
      }
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
      // ensure both chore and target user belong to the household
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
    type: ChoreAssignmentRef,
    authScopes: { authenticated: true },
    args: { assignmentId: t.arg({ type: "UUID", required: true }) },
    resolve: async (_root, args, ctx) => {
      const v = requireViewer(ctx);
      const assignment = await ctx.db
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
      const updated = await ctx.db
        .updateTable("chore_assignments")
        .set({
          status: "submitted",
          submitted_at: new Date(),
          reject_reason: null,
        })
        .where("id", "=", args.assignmentId)
        .returningAll()
        .executeTakeFirstOrThrow();
      return updated;
    },
  }),
);

builder.mutationField("approveChore", (t) =>
  t.field({
    type: ChoreAssignmentRef,
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
            "c.kind as kind",
            "c.recurrence as recurrence",
            "c.archived as archived",
          ])
          .executeTakeFirst();
        if (!row) throw new Error("Assignment not found");
        if (row.a_status === "approved") throw new Error("Already approved");

        const updated = await trx
          .updateTable("chore_assignments")
          .set({
            status: "approved",
            approved_at: new Date(),
            approved_by_user_id: v.userId,
            reject_reason: null,
          })
          .where("id", "=", args.assignmentId)
          .returningAll()
          .executeTakeFirstOrThrow();

        await trx
          .updateTable("users")
          .set((eb) => ({ token_balance: eb("token_balance", "+", row.token_value) }))
          .where("id", "=", row.a_user)
          .execute();

        // Auto-spawn the next instance only for scheduled recurring chores.
        // On-demand chores rely on the kid claiming again — no implicit
        // assignment, only a cooldown gate enforced in claimChore.
        if (
          !row.archived &&
          row.kind === "scheduled" &&
          row.recurrence !== "one_off"
        ) {
          const base = row.a_due_date ?? new Date();
          const nextDue = new Date(base);
          if (row.recurrence === "daily") nextDue.setDate(nextDue.getDate() + 1);
          if (row.recurrence === "weekly") nextDue.setDate(nextDue.getDate() + 7);
          // Skip if a non-finalized assignment for the same chore+user already exists.
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

        return updated;
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
      const found = await ctx.db
        .selectFrom("chore_assignments as a")
        .innerJoin("chores as c", "c.id", "a.chore_id")
        .where("a.id", "=", args.assignmentId)
        .where("c.household_id", "=", v.householdId)
        .select("a.id")
        .executeTakeFirst();
      if (!found) throw new Error("Assignment not found");
      return ctx.db
        .updateTable("chore_assignments")
        .set({
          status: "rejected",
          reject_reason: args.reason ?? null,
          submitted_at: null,
        })
        .where("id", "=", args.assignmentId)
        .returningAll()
        .executeTakeFirstOrThrow();
    },
  }),
);

// On-demand chores: the kid (or any household member) self-claims a chore
// they just did. Creates a `submitted` assignment for the viewer; an adult
// still has to approve before tokens are credited. The cooldown blocks
// re-claiming until cooldown_minutes have elapsed since the last approval
// of this chore by this user.
builder.mutationField("claimChore", (t) =>
  t.field({
    type: ChoreAssignmentRef,
    authScopes: { authenticated: true },
    args: { choreId: t.arg({ type: "UUID", required: true }) },
    resolve: async (_root, args, ctx) => {
      const v = requireViewer(ctx);
      return ctx.db.transaction().execute(async (trx) => {
        const chore = await trx
          .selectFrom("chores")
          .select(["id", "kind", "cooldown_minutes", "archived"])
          .where("id", "=", args.choreId)
          .where("household_id", "=", v.householdId)
          .executeTakeFirst();
        if (!chore) throw new Error("Chore not in your household");
        if (chore.archived) throw new Error("Chore is archived");
        if (chore.kind !== "on_demand") {
          throw new Error("This chore must be assigned by an adult");
        }

        // Reject if there's already an open (non-finalized) claim by this user.
        const open = await trx
          .selectFrom("chore_assignments")
          .select("id")
          .where("chore_id", "=", chore.id)
          .where("assigned_to_user_id", "=", v.userId)
          .where("status", "in", ["pending", "submitted", "rejected"])
          .executeTakeFirst();
        if (open) throw new Error("You already have an open claim on this chore");

        // Cooldown check.
        if (chore.cooldown_minutes > 0) {
          const last = await trx
            .selectFrom("chore_assignments")
            .select("approved_at")
            .where("chore_id", "=", chore.id)
            .where("assigned_to_user_id", "=", v.userId)
            .where("status", "=", "approved")
            .orderBy("approved_at", "desc")
            .limit(1)
            .executeTakeFirst();
          if (last?.approved_at) {
            const ready = new Date(last.approved_at);
            ready.setMinutes(ready.getMinutes() + chore.cooldown_minutes);
            if (Date.now() < ready.getTime()) {
              const minsLeft = Math.ceil(
                (ready.getTime() - Date.now()) / 60_000,
              );
              throw new Error(
                `On cooldown — try again in ${minsLeft} minute${minsLeft === 1 ? "" : "s"}`,
              );
            }
          }
        }

        return trx
          .insertInto("chore_assignments")
          .values({
            chore_id: chore.id,
            assigned_to_user_id: v.userId,
            status: "submitted",
            submitted_at: new Date(),
          })
          .returningAll()
          .executeTakeFirstOrThrow();
      });
    },
  }),
);
