import type { Generated } from "kysely";

export type Role = "adult" | "child";
export type Recurrence = "one_off" | "daily" | "weekly";
export type ChoreStatus = "pending" | "submitted" | "approved" | "rejected";
export type RedemptionStatus = "requested" | "approved" | "denied" | "fulfilled";

type Timestamp = Date;

export interface HouseholdsTable {
  id: Generated<string>;
  name: string;
  created_at: Generated<Timestamp>;
}

export interface UsersTable {
  id: Generated<string>;
  household_id: string;
  name: string;
  role: Role;
  email: string | null;
  password_hash: string | null;
  pin_hash: string | null;
  avatar_emoji: string;
  token_balance: Generated<number>;
  created_at: Generated<Timestamp>;
}

export interface ChoresTable {
  id: Generated<string>;
  household_id: string;
  title: string;
  description: string | null;
  token_value: number;
  recurrence: Recurrence;
  created_by_user_id: string;
  archived: Generated<boolean>;
  created_at: Generated<Timestamp>;
}

export interface ChoreAssignmentsTable {
  id: Generated<string>;
  chore_id: string;
  assigned_to_user_id: string;
  due_date: Timestamp | null;
  status: Generated<ChoreStatus>;
  submitted_at: Timestamp | null;
  approved_at: Timestamp | null;
  approved_by_user_id: string | null;
  reject_reason: string | null;
  created_at: Generated<Timestamp>;
}

export interface RewardsTable {
  id: Generated<string>;
  household_id: string;
  title: string;
  description: string | null;
  token_cost: number;
  created_by_user_id: string;
  archived: Generated<boolean>;
  created_at: Generated<Timestamp>;
}

export interface RedemptionsTable {
  id: Generated<string>;
  reward_id: string;
  user_id: string;
  tokens_spent: number;
  status: Generated<RedemptionStatus>;
  requested_at: Generated<Timestamp>;
  decided_at: Timestamp | null;
  decided_by_user_id: string | null;
  decision_reason: string | null;
}

export interface DB {
  households: HouseholdsTable;
  users: UsersTable;
  chores: ChoresTable;
  chore_assignments: ChoreAssignmentsTable;
  rewards: RewardsTable;
  redemptions: RedemptionsTable;
}
