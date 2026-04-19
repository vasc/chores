import SchemaBuilder from "@pothos/core";
import ScopeAuthPlugin from "@pothos/plugin-scope-auth";
import { DateTimeResolver } from "graphql-scalars";
import type { AppContext } from "../context.ts";

export const builder = new SchemaBuilder<{
  Context: AppContext;
  AuthScopes: {
    authenticated: boolean;
    adult: boolean;
  };
  Scalars: {
    DateTime: { Input: Date; Output: Date };
    UUID: { Input: string; Output: string };
  };
  DefaultFieldNullability: false;
}>({
  plugins: [ScopeAuthPlugin],
  defaultFieldNullability: false,
  scopeAuth: {
    authScopes: (ctx) => ({
      authenticated: ctx.viewer != null,
      adult: ctx.viewer?.role === "adult",
    }),
  },
});

builder.addScalarType("DateTime", DateTimeResolver);
builder.scalarType("UUID", {
  serialize: (v) => String(v),
  parseValue: (v) => {
    if (typeof v !== "string") throw new Error("UUID must be string");
    return v;
  },
});

builder.queryType({});
builder.mutationType({});
