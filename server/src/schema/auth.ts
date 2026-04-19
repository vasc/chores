import { z } from "zod";
import { builder } from "./builder.ts";
import { signToken } from "../auth/jwt.ts";
import { hashPassword, verifyPassword } from "../auth/password.ts";
import { hashPin, validatePin, verifyPin } from "../auth/pin.ts";
import { requireAdult } from "../context.ts";
import { AuthPayloadRef, UserRef } from "./types.ts";

const emailSchema = z.string().email().max(254);
const passwordSchema = z.string().min(8).max(200);
const nameSchema = z.string().trim().min(1).max(80);

builder.mutationField("signUpHousehold", (t) =>
  t.field({
    type: AuthPayloadRef,
    args: {
      householdName: t.arg.string({ required: true }),
      adultName: t.arg.string({ required: true }),
      email: t.arg.string({ required: true }),
      password: t.arg.string({ required: true }),
    },
    resolve: async (_root, args, ctx) => {
      const householdName = nameSchema.parse(args.householdName);
      const adultName = nameSchema.parse(args.adultName);
      const email = emailSchema.parse(args.email);
      const password = passwordSchema.parse(args.password);

      const existing = await ctx.db
        .selectFrom("users")
        .select("id")
        .where("email", "=", email)
        .executeTakeFirst();
      if (existing) throw new Error("Email already in use");

      const passwordHash = await hashPassword(password);

      return ctx.db.transaction().execute(async (trx) => {
        const household = await trx
          .insertInto("households")
          .values({ name: householdName })
          .returningAll()
          .executeTakeFirstOrThrow();
        const user = await trx
          .insertInto("users")
          .values({
            household_id: household.id,
            name: adultName,
            role: "adult",
            email,
            password_hash: passwordHash,
            avatar_emoji: "🧑",
          })
          .returningAll()
          .executeTakeFirstOrThrow();
        const token = await signToken({
          userId: user.id,
          householdId: household.id,
          role: "adult",
        });
        return { token, user };
      });
    },
  }),
);

builder.mutationField("loginAdult", (t) =>
  t.field({
    type: AuthPayloadRef,
    args: {
      email: t.arg.string({ required: true }),
      password: t.arg.string({ required: true }),
    },
    resolve: async (_root, args, ctx) => {
      const email = emailSchema.parse(args.email);
      const user = await ctx.db
        .selectFrom("users")
        .selectAll()
        .where("email", "=", email)
        .where("role", "=", "adult")
        .executeTakeFirst();
      if (!user || !user.password_hash) throw new Error("Invalid credentials");
      const ok = await verifyPassword(args.password, user.password_hash);
      if (!ok) throw new Error("Invalid credentials");
      const token = await signToken({
        userId: user.id,
        householdId: user.household_id,
        role: "adult",
      });
      return { token, user };
    },
  }),
);

builder.mutationField("kidLogin", (t) =>
  t.field({
    type: AuthPayloadRef,
    args: {
      userId: t.arg({ type: "UUID", required: true }),
      pin: t.arg.string({ required: true }),
    },
    resolve: async (_root, args, ctx) => {
      validatePin(args.pin);
      const user = await ctx.db
        .selectFrom("users")
        .selectAll()
        .where("id", "=", args.userId)
        .where("role", "=", "child")
        .executeTakeFirst();
      if (!user || !user.pin_hash) throw new Error("Invalid PIN");
      const ok = await verifyPin(args.pin, user.pin_hash);
      if (!ok) throw new Error("Invalid PIN");
      const token = await signToken({
        userId: user.id,
        householdId: user.household_id,
        role: "child",
      });
      return { token, user };
    },
  }),
);

builder.mutationField("addChild", (t) =>
  t.field({
    type: UserRef,
    authScopes: { adult: true },
    args: {
      name: t.arg.string({ required: true }),
      pin: t.arg.string({ required: true }),
      avatarEmoji: t.arg.string(),
    },
    resolve: async (_root, args, ctx) => {
      const viewer = requireAdult(ctx);
      const name = nameSchema.parse(args.name);
      const pinHash = await hashPin(args.pin);
      return ctx.db
        .insertInto("users")
        .values({
          household_id: viewer.householdId,
          name,
          role: "child",
          pin_hash: pinHash,
          avatar_emoji: args.avatarEmoji ?? "🧒",
        })
        .returningAll()
        .executeTakeFirstOrThrow();
    },
  }),
);

builder.mutationField("addAdult", (t) =>
  t.field({
    type: UserRef,
    authScopes: { adult: true },
    args: {
      name: t.arg.string({ required: true }),
      email: t.arg.string({ required: true }),
      password: t.arg.string({ required: true }),
    },
    resolve: async (_root, args, ctx) => {
      const viewer = requireAdult(ctx);
      const name = nameSchema.parse(args.name);
      const email = emailSchema.parse(args.email);
      const password = passwordSchema.parse(args.password);
      const passwordHash = await hashPassword(password);
      return ctx.db
        .insertInto("users")
        .values({
          household_id: viewer.householdId,
          name,
          role: "adult",
          email,
          password_hash: passwordHash,
          avatar_emoji: "🧑",
        })
        .returningAll()
        .executeTakeFirstOrThrow();
    },
  }),
);

builder.mutationField("updateChildPin", (t) =>
  t.field({
    type: UserRef,
    authScopes: { adult: true },
    args: {
      userId: t.arg({ type: "UUID", required: true }),
      newPin: t.arg.string({ required: true }),
    },
    resolve: async (_root, args, ctx) => {
      const viewer = requireAdult(ctx);
      const pinHash = await hashPin(args.newPin);
      const updated = await ctx.db
        .updateTable("users")
        .set({ pin_hash: pinHash })
        .where("id", "=", args.userId)
        .where("household_id", "=", viewer.householdId)
        .where("role", "=", "child")
        .returningAll()
        .executeTakeFirst();
      if (!updated) throw new Error("Child not found");
      return updated;
    },
  }),
);
