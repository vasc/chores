import { SignJWT, jwtVerify } from "jose";
import { env } from "../env.ts";
import type { Role } from "../db/types.ts";

const secret = new TextEncoder().encode(env.JWT_SECRET);

export interface TokenPayload {
  userId: string;
  householdId: string;
  role: Role;
}

const ADULT_TTL = "30d";
const CHILD_TTL = "8h";

export async function signToken(payload: TokenPayload): Promise<string> {
  return new SignJWT({ ...payload })
    .setProtectedHeader({ alg: "HS256" })
    .setIssuedAt()
    .setExpirationTime(payload.role === "adult" ? ADULT_TTL : CHILD_TTL)
    .sign(secret);
}

export async function verifyToken(token: string): Promise<TokenPayload | null> {
  try {
    const { payload } = await jwtVerify(token, secret);
    if (
      typeof payload.userId === "string" &&
      typeof payload.householdId === "string" &&
      (payload.role === "adult" || payload.role === "child")
    ) {
      return {
        userId: payload.userId,
        householdId: payload.householdId,
        role: payload.role,
      };
    }
    return null;
  } catch {
    return null;
  }
}
