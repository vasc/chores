import type { Selectable } from "kysely";
import { builder } from "./builder.ts";
import type {
  ChoreAssignments,
  Chores,
  Households,
  Redemptions,
  Rewards,
  Users,
} from "../db/generated.ts";
import {
  ChoreKindEnum,
  ChoreStatusEnum,
  RecurrenceEnum,
  RedemptionStatusEnum,
  RoleEnum,
} from "./enums.ts";

export type HouseholdRow = Selectable<Households>;
export type UserRow = Selectable<Users>;
export type ChoreRow = Selectable<Chores>;
export type AssignmentRow = Selectable<ChoreAssignments>;
export type RewardRow = Selectable<Rewards>;
export type RedemptionRow = Selectable<Redemptions>;

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
    kind: t.field({ type: ChoreKindEnum, resolve: (c) => c.kind }),
    recurrence: t.field({ type: RecurrenceEnum, resolve: (c) => c.recurrence }),
    cooldownMinutes: t.exposeInt("cooldown_minutes"),
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

export const AuthPayloadRef = builder
  .objectRef<{ token: string; user: UserRow }>("AuthPayload")
  .implement({
    fields: (t) => ({
      token: t.exposeString("token"),
      user: t.field({ type: UserRef, resolve: (p) => p.user }),
    }),
  });
