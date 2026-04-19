# CLAUDE.md

Guidance for Claude (or any assistant) working in this repository.

## TL;DR

- **Two subprojects**: `server/` (Bun + TypeScript + GraphQL Yoga + Pothos + Kysely + Postgres) and `app/` (Flutter for iOS, Android, macOS).
- **Contract between them**: GraphQL SDL at `server/schema.graphql`. Server is code-first via Pothos and prints the SDL. Client consumes the SDL plus `.graphql` operation files via `graphql_codegen` to produce typed Dart.
- **Always resync the schema** after any server schema change: `cd server && bun run sync` copies SDL to `app/lib/graphql/schema.graphql`. Then in `app/` run `dart run build_runner build --delete-conflicting-outputs`.
- **Database**: Postgres via Kysely. Migrations in `server/src/db/migrations/`. Run with `bun run migrate`.
- **Auth**: JWT (HS256, `jose`). Adults 30-day TTL, kids 8h. Scope-auth plugin gates adult-only mutations.

## Repository layout

```
/
├── README.md                       Top-level quick start
├── CLAUDE.md                       This file
├── docs/
│   ├── ARCHITECTURE.md             System overview, data flow
│   ├── API.md                      GraphQL schema walkthrough
│   └── DEVELOPMENT.md              Day-to-day dev workflow
├── server/                         Bun + GraphQL backend
│   ├── README.md
│   ├── package.json
│   ├── tsconfig.json
│   ├── schema.graphql              Generated SDL (committed)
│   ├── scripts/e2e.sh              End-to-end smoke test
│   └── src/
│       ├── index.ts                Bun.serve + Yoga
│       ├── env.ts                  Zod-validated env
│       ├── context.ts              Request context (db, viewer)
│       ├── db/
│       │   ├── kysely.ts           PG pool + Kysely instance
│       │   ├── types.ts            DB row types
│       │   ├── migrate.ts          Migration runner CLI
│       │   └── migrations/
│       │       └── 0001_init.ts    Full schema
│       ├── auth/
│       │   ├── jwt.ts              sign/verify via jose
│       │   ├── password.ts         bcrypt for adults
│       │   └── pin.ts              bcrypt (cost 6) for kids
│       └── schema/
│           ├── builder.ts          Pothos SchemaBuilder + scalars + scope auth
│           ├── enums.ts            Role, ChoreStatus, etc.
│           ├── types.ts            Object type refs (User, Chore, …)
│           ├── queries.ts          Root Query resolvers
│           ├── auth.ts             Auth mutations
│           ├── chores.ts           Chore + assignment mutations
│           ├── rewards.ts          Reward + redemption mutations
│           ├── print.ts            `bun run schema` entry
│           └── index.ts            Assembles schema
└── app/                            Flutter client
    ├── README.md
    ├── pubspec.yaml
    ├── analysis_options.yaml
    ├── build.yaml                  graphql_codegen config
    ├── android/ ios/ macos/        Platform folders
    ├── test/
    └── lib/
        ├── main.dart
        ├── theme.dart
        ├── router.dart             go_router with auth-aware redirect
        ├── auth/
        │   ├── auth_storage.dart   flutter_secure_storage JWT
        │   ├── household_storage.dart
        │   └── auth_controller.dart (Riverpod)
        ├── client/
        │   └── graphql_client.dart HttpLink + AuthLink
        ├── graphql/
        │   ├── schema.graphql      Synced from server
        │   └── operations/         *.graphql + generated *.graphql.dart
        ├── widgets/
        │   └── error_box.dart
        └── screens/
            ├── splash_screen.dart
            ├── welcome_screen.dart
            ├── adult_signup.dart
            ├── adult_login.dart
            ├── kid_picker_screen.dart
            ├── home_chores_screen.dart
            ├── chore_detail_screen.dart
            ├── rewards_screen.dart
            ├── approvals_screen.dart
            └── admin/
                └── admin_screen.dart   (tabs: Members/Chores/Rewards)
```

## Core workflows

### Adding a GraphQL field or type

1. Edit the relevant file in `server/src/schema/` (Pothos is code-first).
2. From `server/`: `bun run typecheck` — catches most resolver type errors.
3. From `server/`: `bun run sync` — regenerates SDL and copies it to `app/`.
4. Add / edit the corresponding `.graphql` operation file under `app/lib/graphql/operations/` if the client needs it.
5. From `app/`: `dart run build_runner build --delete-conflicting-outputs` — regenerates typed Dart.
6. Dart compile errors will now surface any broken usage of renamed/removed fields.

### Adding a database column or table

1. Create a **new** migration file `server/src/db/migrations/000N_description.ts` (do **not** edit `0001_init.ts` — migrations are append-only).
2. Update `server/src/db/types.ts` with the matching table / column types.
3. `bun run migrate` to apply.
4. Surface new fields via Pothos in `server/src/schema/types.ts`.
5. Re-sync + regen as above.

### Writing a resolver

- Resolvers receive `(root, args, ctx)` where `ctx.db` is Kysely and `ctx.viewer` is the decoded JWT (or `null` for unauth).
- Use `requireAdult(ctx)` / `requireAuth(ctx)` from `context.ts` to enforce auth at the top of resolvers when scope-auth isn't enough.
- Scope auth on adult-only mutations: declare `authScopes: { adult: true }` — the plugin handles the check.
- Always scope DB reads/writes by `ctx.viewer.householdId`. There is **no household ID argument** on most queries — the viewer's household is implicit. This prevents tenant leaks.
- Wrap token-mutating logic in `ctx.db.transaction().execute(async (trx) => { … })`. See `approveChore` and `approveRedemption` for the pattern.

### Token accounting rules

- `approveChore`: credit `user.token_balance += chore.token_value`. If the chore's `recurrence` is `daily` / `weekly`, insert the next assignment (skip if a non-finalized one already exists for the same chore+user).
- `requestRedemption`: validate `user.token_balance >= reward.token_cost`, create redemption with `status=requested`. **Do not debit yet.**
- `approveRedemption`: transition `requested → approved` and debit `user.token_balance -= redemption.tokens_spent`.
- `denyRedemption`: transition `requested → denied`. No debit.
- `fulfillRedemption`: transition `approved → fulfilled`. No balance change.

Never increment or decrement a balance outside a transaction — a concurrent approve/deny can cause double spend.

## Auth model

- **Household signup**: one adult creates the household + themselves. `signUpHousehold(householdName, adultName, email, password)` returns `AuthPayload { token, user }`.
- **Adding an adult**: existing adult calls `addAdult(name, email, password)`. That adult can then log in via `loginAdult`.
- **Adding a child**: adult calls `addChild(name, pin, avatarEmoji)`. Children do **not** have email/password, only a bcrypted 4-digit PIN.
- **Kid login**: two-step flow:
  1. `kidsForLogin(householdId)` — **public** query (no auth required); returns the household's children so the picker can render avatars + names.
  2. `kidLogin(userId, pin)` — returns an `AuthPayload` with an 8-hour JWT.
- **Household ID on kid devices**: stored separately in `household_storage.dart` so the kid picker survives logout. Adults don't need this — their JWT is self-contained.

## Codegen gotchas

- Add new operation files to `app/lib/graphql/operations/` (one `.graphql` file per logical group). Fragments go in `fragments.graphql` and are referenced by name.
- `graphql_codegen` emits classes like `Query$Home`, `Variables$Mutation$ApproveChore`, `documentNodeQueryHome`. Import them from the generated `*.graphql.dart` next to the source.
- **Never hand-edit `*.graphql.dart`.** They're regenerated every build.
- If you see "schema mismatch" errors during codegen, resync the schema from the server: `bun run sync` in `server/`.
- If you rename an operation, delete the old `*.graphql.dart` before regenerating (or pass `--delete-conflicting-outputs`, which this repo's commands do).

## Dev loop commands

From repo root:

```bash
# Server
cd server
bun run dev         # watch mode, GraphiQL at :4000/graphql
bun run typecheck   # tsc --noEmit
bun run migrate     # apply pending migrations
bun run sync        # regen SDL and copy to app/

# Client (in another terminal)
cd app
dart run build_runner watch --delete-conflicting-outputs
flutter analyze
flutter test
flutter run -d macos   # or -d ios / -d android
```

End-to-end smoke test of the backend:

```bash
cd server
bun run dev &
sleep 2
DATABASE_URL=postgres://chores:chores@localhost:5432/chores bash scripts/e2e.sh
```

## Platform notes

- **Android**: dev traffic to `http://10.0.2.2:4000` (emulator) or `http://localhost:4000` is permitted only for those hosts via `app/android/app/src/main/res/xml/network_security_config.xml`. Internet permission is declared in the manifest.
- **iOS**: `NSAppTransportSecurity > NSAllowsLocalNetworking` permits cleartext to localhost in debug. Production deployment must serve the API over HTTPS.
- **macOS**: the app is sandboxed. Entitlements include `com.apple.security.network.client` (Debug + Release) and `com.apple.security.network.server` (Debug only, for Flutter's dev service). If you need filesystem access, add `com.apple.security.files.user-selected.read-write`.
- **Cleartext in prod**: the current network configs are deliberately permissive for localhost development. Before shipping, tighten them and switch `API_URL` to an HTTPS endpoint.

## Don't

- Don't edit `*.graphql.dart` files — regenerate instead.
- Don't edit `0001_init.ts` after it has been applied — add a new migration.
- Don't skip the transaction wrapper on token-mutating resolvers.
- Don't call resolvers without scoping by `ctx.viewer.householdId`.
- Don't introduce a second HTTP client in the Flutter app — everything goes through `graphqlClientProvider` so auth headers + cache stay consistent.
- Don't commit `.env` files (they're gitignored). The server validates required env via Zod at boot.

## When adding a new feature

A rough checklist to stay consistent with the existing shape:

1. **DB** — migration + `db/types.ts`.
2. **GraphQL types** — add/extend a `builder.objectRef<…>(…).implement(…)` in `schema/types.ts`.
3. **Query / mutation** — add to the matching file under `schema/`. Use `authScopes` for adult-only ones. Wrap state-changing logic in a transaction when it touches `users.token_balance`.
4. **Resync + regen** — `bun run sync` then `dart run build_runner build --delete-conflicting-outputs`.
5. **Operation file** — add a named operation in `app/lib/graphql/operations/<feature>.graphql`. Prefer fragments for shared shapes.
6. **Screen or widget** — consume via `Query` / `Mutation` widgets from `graphql_flutter`, passing the generated `documentNode...` and `Variables$...` types. Use the shared `prettifyError` helper for user-facing errors.
7. **Test** — extend `server/scripts/e2e.sh` for the backend happy path; add a widget test if the UI has non-trivial logic.
