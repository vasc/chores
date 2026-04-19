import { builder } from "./builder.ts";
import "./types.ts";
import "./auth.ts";
import "./queries.ts";
import "./chores.ts";
import "./rewards.ts";

export const schema = builder.toSchema();
