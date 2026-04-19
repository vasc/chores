import { type Kysely, sql } from "kysely";

export async function up(db: Kysely<unknown>): Promise<void> {
  await sql`CREATE EXTENSION IF NOT EXISTS pgcrypto`.execute(db);
  await sql`CREATE EXTENSION IF NOT EXISTS citext`.execute(db);

  await db.schema
    .createType("user_role")
    .asEnum(["adult", "child"])
    .execute();
  await db.schema
    .createType("recurrence_type")
    .asEnum(["one_off", "daily", "weekly"])
    .execute();
  await db.schema
    .createType("chore_status")
    .asEnum(["pending", "submitted", "approved", "rejected"])
    .execute();
  await db.schema
    .createType("redemption_status")
    .asEnum(["requested", "approved", "denied", "fulfilled"])
    .execute();

  await db.schema
    .createTable("households")
    .addColumn("id", "uuid", (c) => c.primaryKey().defaultTo(sql`gen_random_uuid()`))
    .addColumn("name", "text", (c) => c.notNull())
    .addColumn("created_at", "timestamptz", (c) => c.notNull().defaultTo(sql`now()`))
    .execute();

  await db.schema
    .createTable("users")
    .addColumn("id", "uuid", (c) => c.primaryKey().defaultTo(sql`gen_random_uuid()`))
    .addColumn("household_id", "uuid", (c) => c.notNull().references("households.id").onDelete("cascade"))
    .addColumn("name", "text", (c) => c.notNull())
    .addColumn("role", sql`user_role`, (c) => c.notNull())
    .addColumn("email", sql`citext`, (c) => c.unique())
    .addColumn("password_hash", "text")
    .addColumn("pin_hash", "text")
    .addColumn("avatar_emoji", "text", (c) => c.notNull().defaultTo("🙂"))
    .addColumn("token_balance", "integer", (c) => c.notNull().defaultTo(0))
    .addColumn("created_at", "timestamptz", (c) => c.notNull().defaultTo(sql`now()`))
    .addCheckConstraint(
      "users_credentials_match_role",
      sql`(
        (role = 'adult' AND email IS NOT NULL AND password_hash IS NOT NULL AND pin_hash IS NULL) OR
        (role = 'child' AND email IS NULL AND password_hash IS NULL AND pin_hash IS NOT NULL)
      )`,
    )
    .execute();
  await db.schema.createIndex("users_household_idx").on("users").column("household_id").execute();

  await db.schema
    .createTable("chores")
    .addColumn("id", "uuid", (c) => c.primaryKey().defaultTo(sql`gen_random_uuid()`))
    .addColumn("household_id", "uuid", (c) => c.notNull().references("households.id").onDelete("cascade"))
    .addColumn("title", "text", (c) => c.notNull())
    .addColumn("description", "text")
    .addColumn("token_value", "integer", (c) => c.notNull().check(sql`token_value >= 0`))
    .addColumn("recurrence", sql`recurrence_type`, (c) => c.notNull().defaultTo("one_off"))
    .addColumn("created_by_user_id", "uuid", (c) => c.notNull().references("users.id").onDelete("restrict"))
    .addColumn("archived", "boolean", (c) => c.notNull().defaultTo(false))
    .addColumn("created_at", "timestamptz", (c) => c.notNull().defaultTo(sql`now()`))
    .execute();
  await db.schema.createIndex("chores_household_idx").on("chores").column("household_id").execute();

  await db.schema
    .createTable("chore_assignments")
    .addColumn("id", "uuid", (c) => c.primaryKey().defaultTo(sql`gen_random_uuid()`))
    .addColumn("chore_id", "uuid", (c) => c.notNull().references("chores.id").onDelete("cascade"))
    .addColumn("assigned_to_user_id", "uuid", (c) => c.notNull().references("users.id").onDelete("cascade"))
    .addColumn("due_date", "timestamptz")
    .addColumn("status", sql`chore_status`, (c) => c.notNull().defaultTo("pending"))
    .addColumn("submitted_at", "timestamptz")
    .addColumn("approved_at", "timestamptz")
    .addColumn("approved_by_user_id", "uuid", (c) => c.references("users.id").onDelete("set null"))
    .addColumn("reject_reason", "text")
    .addColumn("created_at", "timestamptz", (c) => c.notNull().defaultTo(sql`now()`))
    .execute();
  await db.schema.createIndex("assignments_user_idx").on("chore_assignments").column("assigned_to_user_id").execute();
  await db.schema.createIndex("assignments_status_idx").on("chore_assignments").column("status").execute();

  await db.schema
    .createTable("rewards")
    .addColumn("id", "uuid", (c) => c.primaryKey().defaultTo(sql`gen_random_uuid()`))
    .addColumn("household_id", "uuid", (c) => c.notNull().references("households.id").onDelete("cascade"))
    .addColumn("title", "text", (c) => c.notNull())
    .addColumn("description", "text")
    .addColumn("token_cost", "integer", (c) => c.notNull().check(sql`token_cost >= 0`))
    .addColumn("created_by_user_id", "uuid", (c) => c.notNull().references("users.id").onDelete("restrict"))
    .addColumn("archived", "boolean", (c) => c.notNull().defaultTo(false))
    .addColumn("created_at", "timestamptz", (c) => c.notNull().defaultTo(sql`now()`))
    .execute();
  await db.schema.createIndex("rewards_household_idx").on("rewards").column("household_id").execute();

  await db.schema
    .createTable("redemptions")
    .addColumn("id", "uuid", (c) => c.primaryKey().defaultTo(sql`gen_random_uuid()`))
    .addColumn("reward_id", "uuid", (c) => c.notNull().references("rewards.id").onDelete("cascade"))
    .addColumn("user_id", "uuid", (c) => c.notNull().references("users.id").onDelete("cascade"))
    .addColumn("tokens_spent", "integer", (c) => c.notNull().check(sql`tokens_spent >= 0`))
    .addColumn("status", sql`redemption_status`, (c) => c.notNull().defaultTo("requested"))
    .addColumn("requested_at", "timestamptz", (c) => c.notNull().defaultTo(sql`now()`))
    .addColumn("decided_at", "timestamptz")
    .addColumn("decided_by_user_id", "uuid", (c) => c.references("users.id").onDelete("set null"))
    .addColumn("decision_reason", "text")
    .execute();
  await db.schema.createIndex("redemptions_user_idx").on("redemptions").column("user_id").execute();
  await db.schema.createIndex("redemptions_status_idx").on("redemptions").column("status").execute();
}

export async function down(db: Kysely<unknown>): Promise<void> {
  await db.schema.dropTable("redemptions").ifExists().execute();
  await db.schema.dropTable("rewards").ifExists().execute();
  await db.schema.dropTable("chore_assignments").ifExists().execute();
  await db.schema.dropTable("chores").ifExists().execute();
  await db.schema.dropTable("users").ifExists().execute();
  await db.schema.dropTable("households").ifExists().execute();
  await sql`DROP TYPE IF EXISTS redemption_status`.execute(db);
  await sql`DROP TYPE IF EXISTS chore_status`.execute(db);
  await sql`DROP TYPE IF EXISTS recurrence_type`.execute(db);
  await sql`DROP TYPE IF EXISTS user_role`.execute(db);
}
