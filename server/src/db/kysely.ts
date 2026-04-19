import { Kysely, PostgresDialect } from "kysely";
import pg from "pg";
import { env } from "../env.ts";
import type { DB } from "./types.ts";

const pool = new pg.Pool({ connectionString: env.DATABASE_URL });

export const db = new Kysely<DB>({
  dialect: new PostgresDialect({ pool }),
});

export async function closeDb(): Promise<void> {
  await db.destroy();
}
