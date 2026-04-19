import { promises as fs } from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";
import { lexicographicSortSchema, printSchema } from "graphql";
import { schema } from "./index.ts";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const out = path.resolve(__dirname, "../../schema.graphql");
await fs.writeFile(out, printSchema(lexicographicSortSchema(schema)));
console.log(`✓ Wrote ${path.relative(process.cwd(), out)}`);
