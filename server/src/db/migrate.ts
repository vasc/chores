import { promises as fs } from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";
import { FileMigrationProvider, Migrator } from "kysely";
import { closeDb, db } from "./kysely.ts";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const migrator = new Migrator({
  db,
  provider: new FileMigrationProvider({
    fs,
    path,
    migrationFolder: path.join(__dirname, "migrations"),
  }),
});

const direction = process.argv[2] ?? "up";

async function run() {
  const { results, error } =
    direction === "down" ? await migrator.migrateDown() : await migrator.migrateToLatest();

  results?.forEach((r) => {
    if (r.status === "Success") {
      console.log(`✓ ${r.direction} ${r.migrationName}`);
    } else {
      console.error(`✗ ${r.direction} ${r.migrationName}: ${r.status}`);
    }
  });

  if (error) {
    console.error("Migration failed:", error);
    process.exitCode = 1;
  }

  await closeDb();
}

await run();
