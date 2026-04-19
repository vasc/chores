import { type Kysely, sql } from "kysely";

export async function up(db: Kysely<unknown>): Promise<void> {
  await db.schema
    .createType("chore_kind")
    .asEnum(["scheduled", "on_demand"])
    .execute();

  await db.schema
    .alterTable("chores")
    .addColumn("kind", sql`chore_kind`, (c) => c.notNull().defaultTo("scheduled"))
    .addColumn("cooldown_minutes", "integer", (c) =>
      c.notNull().defaultTo(0).check(sql`cooldown_minutes >= 0`),
    )
    .execute();
}

export async function down(db: Kysely<unknown>): Promise<void> {
  await db.schema.alterTable("chores").dropColumn("cooldown_minutes").execute();
  await db.schema.alterTable("chores").dropColumn("kind").execute();
  await db.schema.dropType("chore_kind").execute();
}
