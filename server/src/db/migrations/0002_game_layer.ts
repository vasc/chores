import { type Kysely, sql } from "kysely";

export async function up(db: Kysely<unknown>): Promise<void> {
  await db.schema
    .createType("loot_rarity")
    .asEnum(["common", "rare", "epic", "legendary"])
    .execute();
  await db.schema
    .createType("loot_drop_status")
    .asEnum(["pending", "committed", "voided"])
    .execute();

  await db.schema
    .alterTable("users")
    .addColumn("xp", "integer", (c) => c.notNull().defaultTo(0).check(sql`xp >= 0`))
    .addColumn("streak_days", "integer", (c) =>
      c.notNull().defaultTo(0).check(sql`streak_days >= 0`))
    .addColumn("streak_last_date", "date")
    .execute();

  await db.schema
    .alterTable("chores")
    .addColumn("xp_value", "integer", (c) =>
      c.notNull().defaultTo(0).check(sql`xp_value >= 0`))
    .execute();

  await db.schema
    .alterTable("chore_assignments")
    .addColumn("combo_at_approval", "integer")
    .execute();

  await db.schema
    .createTable("chore_user_combos")
    .addColumn("chore_id", "uuid", (c) => c.notNull().references("chores.id").onDelete("cascade"))
    .addColumn("user_id", "uuid", (c) => c.notNull().references("users.id").onDelete("cascade"))
    .addColumn("current_combo", "integer", (c) =>
      c.notNull().defaultTo(0).check(sql`current_combo >= 0`))
    .addColumn("last_approved_at", "timestamptz")
    .addColumn("updated_at", "timestamptz", (c) => c.notNull().defaultTo(sql`now()`))
    .addPrimaryKeyConstraint("chore_user_combos_pkey", ["chore_id", "user_id"])
    .execute();

  await db.schema
    .createTable("loot_drops")
    .addColumn("id", "uuid", (c) => c.primaryKey().defaultTo(sql`gen_random_uuid()`))
    .addColumn("user_id", "uuid", (c) => c.notNull().references("users.id").onDelete("cascade"))
    .addColumn("assignment_id", "uuid", (c) =>
      c.references("chore_assignments.id").onDelete("set null"))
    .addColumn("rarity", sql`loot_rarity`, (c) => c.notNull())
    .addColumn("status", sql`loot_drop_status`, (c) => c.notNull().defaultTo("pending"))
    .addColumn("is_quest_bonus", "boolean", (c) => c.notNull().defaultTo(false))
    .addColumn("item_emoji", "text", (c) => c.notNull())
    .addColumn("item_label", "text", (c) => c.notNull())
    .addColumn("item_description", "text", (c) => c.notNull())
    .addColumn("created_at", "timestamptz", (c) => c.notNull().defaultTo(sql`now()`))
    .addColumn("committed_at", "timestamptz")
    .execute();
  await db.schema
    .createIndex("loot_drops_user_idx")
    .on("loot_drops")
    .column("user_id")
    .execute();
  await db.schema
    .createIndex("loot_drops_assignment_idx")
    .on("loot_drops")
    .column("assignment_id")
    .execute();

  await db.schema
    .createTable("user_daily_quests")
    .addColumn("id", "uuid", (c) => c.primaryKey().defaultTo(sql`gen_random_uuid()`))
    .addColumn("user_id", "uuid", (c) => c.notNull().references("users.id").onDelete("cascade"))
    .addColumn("quest_date", "date", (c) => c.notNull())
    .addColumn("goal", "integer", (c) =>
      c.notNull().defaultTo(3).check(sql`goal > 0`))
    .addColumn("progress", "integer", (c) =>
      c.notNull().defaultTo(0).check(sql`progress >= 0`))
    .addColumn("reward_claimed_at", "timestamptz")
    .addColumn("reward_drop_id", "uuid", (c) =>
      c.references("loot_drops.id").onDelete("set null"))
    .addColumn("created_at", "timestamptz", (c) => c.notNull().defaultTo(sql`now()`))
    .addUniqueConstraint("user_daily_quests_user_date_key", ["user_id", "quest_date"])
    .execute();
  await db.schema
    .createIndex("user_daily_quests_user_idx")
    .on("user_daily_quests")
    .column("user_id")
    .execute();
}

export async function down(db: Kysely<unknown>): Promise<void> {
  await db.schema.dropTable("user_daily_quests").ifExists().execute();
  await db.schema.dropTable("loot_drops").ifExists().execute();
  await db.schema.dropTable("chore_user_combos").ifExists().execute();

  await db.schema.alterTable("chore_assignments").dropColumn("combo_at_approval").execute();
  await db.schema.alterTable("chores").dropColumn("xp_value").execute();
  await db.schema.alterTable("users").dropColumn("streak_last_date").execute();
  await db.schema.alterTable("users").dropColumn("streak_days").execute();
  await db.schema.alterTable("users").dropColumn("xp").execute();

  await sql`DROP TYPE IF EXISTS loot_drop_status`.execute(db);
  await sql`DROP TYPE IF EXISTS loot_rarity`.execute(db);
}
