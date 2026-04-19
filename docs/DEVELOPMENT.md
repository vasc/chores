# Development guide

Day-to-day workflow, debugging tips, and testing practices.

## Dev loop

Two terminal panes:

**Pane 1 — server (watch mode):**

```bash
cd server
bun run dev
```

Bun watches `src/` and restarts on change. GraphiQL is at
`http://localhost:4000/graphql`.

**Pane 2 — client (watch mode + runner):**

```bash
cd app
dart run build_runner watch --delete-conflicting-outputs &
flutter run -d macos
```

`build_runner watch` regenerates `*.graphql.dart` whenever you edit a
`.graphql` operation file. Flutter's hot reload picks up Dart changes
within a second or two.

## Making a change end to end

Scenario: add an `emoji` field to chores.

### 1. Migration

```bash
cd server
cat > src/db/migrations/0002_chore_emoji.ts <<'EOF'
import { type Kysely } from "kysely";
export async function up(db: Kysely<unknown>): Promise<void> {
  await db.schema.alterTable("chores")
    .addColumn("emoji", "text", (c) => c.notNull().defaultTo("🧹"))
    .execute();
}
export async function down(db: Kysely<unknown>): Promise<void> {
  await db.schema.alterTable("chores").dropColumn("emoji").execute();
}
EOF
bun run migrate
```

### 2. DB types

Add `emoji: string` to the `chores` row type in `src/db/types.ts`.

### 3. Pothos type

In `src/schema/types.ts`, add to the `Chore` implementation:

```ts
emoji: t.exposeString("emoji"),
```

### 4. Pothos inputs

Update `createChore` and `updateChore` in `src/schema/chores.ts` to accept
an optional `emoji` arg and persist it.

### 5. Typecheck + sync

```bash
bun run typecheck
bun run sync
```

### 6. Client operation

Edit `app/lib/graphql/operations/chores.graphql` to select `emoji` on
`Chore` and (if you added input args) update the mutation variables.

### 7. Regen

```bash
cd app
dart run build_runner build --delete-conflicting-outputs
```

### 8. UI

Consume `chore.emoji` in the screens that render chores.

### 9. Verify

- `bun run scripts/e2e.sh` (adjust if you want the new field covered).
- `flutter analyze`, `flutter test`, then exercise in the app.

## Debugging

### Server

- **GraphiQL** at `http://localhost:4000/graphql` — execute queries with
  the auth header set via the "Headers" pane.
- **Structured logs**: the server prints `method path status duration` for
  each request. Errors include the stack trace in dev.
- **SQL logs**: set `LOG_SQL=1` before `bun run dev` to log every query
  Kysely runs.

### Client

- **`print()` statements** work but prefer `debugPrint()` for long strings
  (it avoids truncation in release logs).
- **GraphQL over-the-wire logging**: in `lib/client/graphql_client.dart`,
  wrap the link chain with `LoggerLink` during debugging.
- **Widget inspector**: `flutter run` → press `i` to toggle.

### Database

Connect with `psql $DATABASE_URL`. Useful queries:

```sql
SELECT id, name, role, token_balance FROM users;
SELECT a.id, c.title, u.name, a.status, a.due_date
  FROM chore_assignments a
  JOIN chores c ON c.id = a.chore_id
  JOIN users u ON u.id = a.assigned_to_user_id
  ORDER BY a.created_at DESC LIMIT 20;
```

Reset state without redoing migrations:

```sql
TRUNCATE redemptions, rewards, chore_assignments, chores, users, households
  RESTART IDENTITY CASCADE;
```

## Testing

### Server

- `bun run typecheck` catches most mistakes without running anything.
- `server/scripts/e2e.sh` drives the GraphQL API with `curl` + `jq`,
  exercising the happy-path of the full chore + reward lifecycle. Expects
  the server already running on `:4000` and a `DATABASE_URL` set.
- Add more cases to `e2e.sh` rather than introducing a second framework.

### Client

- `flutter analyze` is the first gate — must be clean.
- `flutter test` runs widget tests under `app/test/`.

### Manual QA checklist

Walk through this before shipping:

- [ ] Sign up fresh household (rejecting short passwords).
- [ ] Add child, log in as child via PIN picker, log out.
- [ ] Create chore (one_off, daily, weekly), assign, submit, approve.
- [ ] After approving a daily chore, verify the next assignment appears.
- [ ] Reject a chore → kid can resubmit.
- [ ] Create reward, kid redeems, adult approves → balance debits.
- [ ] Adult denies a redemption → no balance change.
- [ ] Archive chore + reward — they disappear from default listings but
      are visible when `includeArchived: true`.
- [ ] Leaderboard reflects updated balances.

## Regenerating platform folders

If `app/ios/`, `app/android/`, or `app/macos/` get corrupted (e.g. after a
major Flutter upgrade), regenerate them:

```bash
cd app
rm -rf ios android macos
flutter create --platforms=ios,android,macos --org com.example --project-name chores .
```

Then **reapply** the platform edits this repo depends on:

- `app/android/app/src/main/AndroidManifest.xml` — `INTERNET` permission
  + `networkSecurityConfig` attribute.
- `app/android/app/src/main/res/xml/network_security_config.xml` —
  localhost cleartext allowlist.
- `app/ios/Runner/Info.plist` — `NSAppTransportSecurity` with
  `NSAllowsLocalNetworking`.
- `app/macos/Runner/DebugProfile.entitlements` and
  `app/macos/Runner/Release.entitlements` — add
  `com.apple.security.network.client`.

## Production checklist

Before pointing the app at a public server:

- [ ] `JWT_SECRET` set to at least 32 random bytes; not committed.
- [ ] `DATABASE_URL` points at a managed Postgres with TLS (`sslmode=require`).
- [ ] Server behind a TLS-terminating reverse proxy (Caddy, Nginx, ALB).
- [ ] CORS origin allowlist narrowed to known app hosts.
- [ ] Remove the dev `NSAllowsLocalNetworking` from iOS Info.plist; require
      HTTPS.
- [ ] Remove localhost cleartext from Android `network_security_config.xml`
      (or restrict to dev build variants).
- [ ] Enable Postgres connection pooling (PgBouncer) if expecting >50
      concurrent devices.
- [ ] Rate-limit `kidLogin` (4-digit PIN is brute-forceable without one).
- [ ] Rotate `JWT_SECRET` and invalidate old tokens on any security incident.

## Common pitfalls

- **"schema mismatch" on codegen**: you changed the server schema but
  didn't run `bun run sync`. Run it and re-run `build_runner`.
- **Dart file disappeared after rename**: `build_runner` caches old
  outputs. Always use `--delete-conflicting-outputs`.
- **Kid picker shows nothing**: `kidsForLogin` needs a `householdId`. On
  a fresh install with no adult ever logged in, you don't have one.
  Adults must sign up first; the household ID is persisted to secure
  storage and survives their logout.
- **`flutter run -d android` can't reach server**: localhost on the
  emulator is the emulator itself, not the host. Use
  `--dart-define=API_URL=http://10.0.2.2:4000/graphql`.
- **Migration fails on fresh DB**: the init migration needs `pgcrypto`
  and `citext` extensions. Either grant the app user superuser on the
  DB, or create the extensions as a superuser first.
- **"expected function, got object" when calling `documentNodeQueryX`**:
  `graphql_codegen` exports `documentNodeQueryX` as a `DocumentNode`
  constant, not a function. Don't call it — just pass it to
  `QueryOptions(document: …)`.
