import type { YogaInitialContext } from "graphql-yoga";
import { db } from "./db/kysely.ts";
import type { Kysely } from "kysely";
import type { DB, Role } from "./db/types.ts";
import { verifyToken } from "./auth/jwt.ts";

export interface Viewer {
  userId: string;
  householdId: string;
  role: Role;
}

export interface AppContext {
  db: Kysely<DB>;
  viewer: Viewer | null;
}

export async function buildContext(
  initial: YogaInitialContext,
): Promise<AppContext> {
  const auth = initial.request.headers.get("authorization") ?? "";
  const token = auth.startsWith("Bearer ") ? auth.slice("Bearer ".length) : null;
  const payload = token ? await verifyToken(token) : null;
  return {
    db,
    viewer: payload,
  };
}

export function requireViewer(ctx: AppContext): Viewer {
  if (!ctx.viewer) throw new Error("Not authenticated");
  return ctx.viewer;
}

export function requireAdult(ctx: AppContext): Viewer {
  const v = requireViewer(ctx);
  if (v.role !== "adult") throw new Error("Adults only");
  return v;
}
