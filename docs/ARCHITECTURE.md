# Architecture

## System overview

```
┌─────────────────────────────────────────────────────────────┐
│  Flutter client (app/)                                      │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ UI layer: screens/ + widgets/                         │  │
│  │   go_router + Riverpod                                │  │
│  └──────────────────┬────────────────────────────────────┘  │
│                     │                                       │
│  ┌──────────────────▼────────────────────────────────────┐  │
│  │ GraphQL client (graphql_flutter)                      │  │
│  │   AuthLink (attaches JWT)  →  HttpLink                │  │
│  │   Normalized in-memory cache                          │  │
│  └──────────────────┬────────────────────────────────────┘  │
└─────────────────────┼───────────────────────────────────────┘
                      │  HTTP POST
                      │  { query, variables }
                      │  Authorization: Bearer <JWT>
                      ▼
┌─────────────────────────────────────────────────────────────┐
│  Bun server (server/)                                       │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ graphql-yoga handler  (Bun.serve)                     │  │
│  │   parses JWT → ctx.viewer { userId, householdId, role}│  │
│  └──────────────────┬────────────────────────────────────┘  │
│                     │                                       │
│  ┌──────────────────▼────────────────────────────────────┐  │
│  │ Pothos schema                                         │  │
│  │   scope-auth plugin gates adult: true                 │  │
│  │   resolvers in schema/{auth,chores,rewards,queries}   │  │
│  └──────────────────┬────────────────────────────────────┘  │
│                     │                                       │
│  ┌──────────────────▼────────────────────────────────────┐  │
│  │ Kysely (typed SQL)  →  Postgres pool                  │  │
│  │   transactions for token credit/debit                 │  │
│  └──────────────────┬────────────────────────────────────┘  │
└─────────────────────┼───────────────────────────────────────┘
                      │
                      ▼
                  Postgres
                 (6 tables)
```

## Type contract

The **single source of truth** is the Pothos-built GraphQL schema in
`server/src/schema/`. We emit SDL text via `printSchema(schema)` to
`server/schema.graphql`, copy it to `app/lib/graphql/schema.graphql`, and
let `graphql_codegen` produce matching Dart classes next to each `.graphql`
operation file.

```
Pothos schema (TS)
      │
      ▼  bun run schema
server/schema.graphql    ◀── committed to VCS
      │
      ▼  bun run sync
app/lib/graphql/schema.graphql
      │
      │  + app/lib/graphql/operations/*.graphql
      ▼  dart run build_runner build
app/lib/graphql/operations/*.graphql.dart
      │
      ▼
Dart code (typed)
```

A rename on the server surfaces as a Dart compile error on the client
after `bun run sync` + `build_runner`.

### End-to-end static guarantees

Every layer is type-checked at compile time and the `.github/workflows/ci.yml`
workflow enforces that the committed artifacts at each boundary match what
would be regenerated from upstream:

| Boundary | Generator | Static check | CI gate |
|---|---|---|---|
| Postgres schema → `server/src/db/generated.ts` | `kysely-codegen` | `tsc` (resolvers use columns that exist) | `bun run db:types:verify` — exits non-zero if the committed file diverges from the live DB |
| Pothos resolvers → `server/schema.graphql` | `printSchema()` in `src/schema/print.ts` | `tsc` (Pothos infers resolver types from the builder) | `bun run schema` + `git diff --exit-code schema.graphql` |
| `server/schema.graphql` → `app/lib/graphql/schema.graphql` | `cp` via `bun run sync` | — | `bun run sync` + `git diff --exit-code` |
| App SDL + `.graphql` operations → `*.graphql.dart` | `graphql_codegen` via `build_runner` | **codegen fails** if an operation selects a field that isn't in the schema | `dart run build_runner build` + `git diff --exit-code`; non-existent fields abort codegen with `Failed to find type for field X on Y` |
| `*.graphql.dart` → screens/widgets | Dart analyzer | `flutter analyze` — removed/renamed fields fail to compile everywhere they're used | `flutter analyze` + `flutter test` |

The **end-to-end static catch**: a Pothos resolver change that removes or
renames a field propagates through `schema.graphql` → Dart codegen → the
analyzer. If the generated Dart no longer has a property, every
`user.removedField` access is a compile error. If you didn't regen, the
diff checks fail first. CI blocks the PR either way. Verified empirically
by removing `tokenBalance` from the Pothos `User` — codegen aborted with
`Invalid GraphQL: Failed to find type for field tokenBalance on User`.

## Component responsibilities

### `server/src/schema/`

- **`builder.ts`** — creates the Pothos `SchemaBuilder`, declares the
  `Context` type, registers the `scope-auth` plugin with `adult` and
  `authenticated` scopes, and registers the `UUID` + `DateTime` scalars.
- **`enums.ts`** — GraphQL enums mirroring DB enum types.
- **`types.ts`** — object type refs (`User`, `Household`, `Chore`,
  `ChoreAssignment`, `Reward`, `Redemption`, `AuthPayload`). These are
  thin wrappers around DB row types; field resolvers pull related rows.
- **`queries.ts`** — root `Query` fields. All scoped by `ctx.viewer.householdId`.
- **`auth.ts`** — `signUpHousehold`, `loginAdult`, `kidLogin`, `addChild`,
  `addAdult`, `updateChildPin`.
- **`chores.ts`** — chore CRUD, assignment, submit, approve/reject.
  Approve runs a transaction that credits tokens and optionally spawns
  the next recurring assignment.
- **`rewards.ts`** — reward CRUD, redemption request/approve/deny/fulfill.
  Approve runs a transaction that debits tokens.
- **`print.ts`** — `bun run schema` entry. Builds the schema and writes
  the SDL to `schema.graphql`.
- **`index.ts`** — assembles the final schema object.

### `server/src/db/`

- **`kysely.ts`** — creates the `pg` pool and Kysely instance. Imports the
  typed `DB` interface from `generated.ts` so resolvers get table completion.
- **`generated.ts`** — emitted by `kysely-codegen` introspecting the live
  Postgres schema. Committed to VCS so fresh clones and CI don't need a DB
  to compile. Regenerated with `bun run db:types`; CI runs
  `bun run db:types:verify` to fail builds when someone forgets to commit
  an update. Never hand-edit — change a migration and re-run.
- **`migrate.ts`** — CLI runner. `up` applies pending migrations; `down`
  rolls back the latest.
- **`migrations/0001_init.ts`** — full initial schema with Postgres enum
  types, foreign keys, and indexes.

### `server/src/auth/`

- **`jwt.ts`** — `sign()` and `verify()` using `jose` (HS256). Adult
  tokens get a 30-day expiry; kid tokens 8 hours.
- **`password.ts`** — bcrypt cost 10 for adult passwords.
- **`pin.ts`** — bcrypt cost 6 for kid PINs (4-digit entropy — higher cost
  would waste CPU without real security gain).

### `server/src/context.ts`

Builds the per-request `Context` object that every resolver receives:

```ts
type Context = {
  db: Kysely<DB>;
  viewer: Viewer | null; // null for unauth requests
};
type Viewer = {
  userId: string;
  householdId: string;
  role: "adult" | "child";
};
```

It also exports helper functions:

- `requireAuth(ctx)` — throws if `viewer` is null; returns the narrowed type.
- `requireAdult(ctx)` — throws if not adult; returns narrowed type.

### `app/lib/client/graphql_client.dart`

Builds the `graphql_flutter` client with two links:

1. **`AuthLink`** — reads the JWT from `flutter_secure_storage` on every
   request and attaches `Authorization: Bearer <token>`.
2. **`HttpLink`** — posts to `API_URL` (defaults to
   `http://localhost:4000/graphql`).

Exposed as a Riverpod provider so screens reach it via `ref.watch`.

### `app/lib/auth/`

- **`auth_storage.dart`** — `flutter_secure_storage` wrapper for the JWT.
- **`household_storage.dart`** — stores the household ID separately so
  the kid picker works after the adult logs out.
- **`auth_controller.dart`** — Riverpod `AsyncNotifier` holding the
  current session (`null`, adult JWT, or kid JWT) and exposing
  `signUp()`, `loginAdult()`, `loginKid()`, `logout()`.

### `app/lib/router.dart`

go_router. Watches the auth controller so transitions happen reactively.
Unauthenticated users land on the welcome screen; authenticated users land
on the home tabbed scaffold. The admin tab is only visible when
`role == adult`.

## Data flow examples

### Adult approves a chore

```
UI
  │ tap "Approve"
  ▼
Mutation$ApproveChore (generated)
  │ graphql_flutter sends { assignmentId } + JWT
  ▼
graphql-yoga
  │ context.ts parses JWT → viewer { role:"adult", ... }
  ▼
approveChore resolver (chores.ts)
  │ scope-auth: requires adult ✓
  │ ctx.db.transaction:
  │   SELECT assignment + chore (scoped to household)
  │   UPDATE chore_assignments SET status='approved', approved_at, approved_by
  │   UPDATE users SET token_balance = token_balance + token_value
  │   if recurrence != one_off:
  │     INSERT INTO chore_assignments (chore_id, user_id, due_date=next)
  ▼
Returns updated ChoreAssignment
  │
  ▼
Client
  │ widget's onCompleted refetches Me + Assignments
  ▼
UI updates
```

### Kid requests a redemption

```
UI
  │ tap "Redeem"
  ▼
Mutation$RequestRedemption
  │ { rewardId } + kid JWT
  ▼
requestRedemption resolver (rewards.ts)
  │ scope-auth: authenticated ✓
  │ SELECT reward (scoped to household)
  │ SELECT user.token_balance
  │ if balance < cost → throw Error
  │ INSERT INTO redemptions (reward_id, user_id, tokens_spent=cost, status='requested')
  ▼
Returns Redemption
```

Note: balance is **not** debited here. The adult's `approveRedemption`
transitions `requested → approved` and debits atomically in a transaction.

## Database schema

```
households (id, name, created_at)
    ├──< users (household_id, name, role, email?, password_hash?,
    │          pin_hash?, avatar_emoji, token_balance)
    ├──< chores (household_id, title, description?, token_value,
    │           recurrence, created_by_user_id, archived)
    │       └──< chore_assignments (chore_id, assigned_to_user_id,
    │                               due_date?, status, submitted_at?,
    │                               approved_at?, approved_by_user_id?,
    │                               reject_reason?)
    └──< rewards (household_id, title, description?, token_cost,
                 created_by_user_id, archived)
            └──< redemptions (reward_id, user_id, tokens_spent, status,
                              requested_at, decided_at?,
                              decided_by_user_id?, decision_reason?)
```

Postgres enum types: `user_role`, `recurrence_type`, `chore_status`,
`redemption_status`.

All `uuid` primary keys are generated with `pgcrypto`'s `gen_random_uuid()`.

## Design decisions worth knowing

### Why GraphQL + codegen, not tRPC?

tRPC is TypeScript on both ends. Dart can't consume its types. GraphQL
has a language-neutral SDL and mature Dart tooling (`graphql_codegen`,
`graphql_flutter`). The codegen pipeline gives us end-to-end types
without being tied to TS on the client.

### Why Pothos (code-first) over schema-first?

Pothos keeps resolvers and types colocated in TS, inferring field
argument types from the resolver signature. Schema-first SDL would
require keeping the resolver types in sync with a separate `.graphql`
file — redundant when TS is already the source language. `printSchema`
gives us the SDL for the client for free.

### Why Kysely instead of Prisma / Drizzle?

Kysely is a thin typed query builder, not an ORM. It produces SQL that
maps 1:1 to what you'd write by hand, which is important when we need
transactional `UPDATE … SET balance = balance + value` — an N+1-safe,
race-safe pattern that's annoying to express in Prisma.

### Why separate JWT for kids with shorter TTL?

Kids often use a shared family device. A shorter TTL means that if a
device walks off, a stolen kid token expires within hours. The PIN is
only four digits — defense-in-depth.

### Why is the household ID on the kid JWT, not a client-side setting?

So resolvers can enforce tenant isolation purely server-side. A client
tampering with IDs in arguments still can't reach another household's
data because every query filters by `ctx.viewer.householdId`.

### Why is there a `household_storage.dart` separate from JWT?

The kid picker (`kidsForLogin`) is called **before** the kid logs in.
No JWT exists yet. We need to know which household to list children for.
Adults who just logged out probably want to hand the device to a kid
from the same household, so we persist the household ID across logout.

### Transactions on state transitions

Every balance-changing mutation runs inside
`ctx.db.transaction().execute(async (trx) => { … })`. Two adults
approving the same submission concurrently would otherwise both credit
the kid; with the transaction, the second UPDATE sees the new status
and errors out.
