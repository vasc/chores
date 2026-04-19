# Chore Tracker

Household chore tracking app with token rewards and adult-approved completions.
Flutter client (iOS, Android, macOS) + Bun TypeScript GraphQL backend.

## Stack

- **Server**: Bun · GraphQL Yoga · Pothos (code-first) · Kysely · Postgres · jose · bcryptjs
- **Client**: Flutter · Riverpod · go_router · graphql_flutter · graphql_codegen
- **Bridge**: GraphQL SDL exported from Pothos, consumed by Dart codegen → end-to-end types

## Quick start

### 1. Server

```bash
cd server
bun install
cp .env.example .env  # set DATABASE_URL and JWT_SECRET
bun run migrate
bun run dev           # http://localhost:4000/graphql
```

### 2. Schema sync

```bash
cd server
bun run sync          # writes ../app/lib/graphql/schema.graphql
```

### 3. Flutter app

```bash
cd app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d macos     # or -d ios / -d android
```

The Flutter app expects the server at `http://localhost:4000/graphql`. Override
with `--dart-define=API_URL=https://...`.

## End-to-end manual test

1. Sign up a household as an adult.
2. Add a child with a 4-digit PIN.
3. Create a chore (e.g. "Dishes", 5 tokens) and assign it to the child.
4. Switch to kid mode, log in with PIN, mark chore done.
5. Switch back to adult, approve the submission — child's balance increases.
6. Create a reward, switch to kid, request redemption, switch back, approve — balance debits.

## Layout

```
server/   Bun + GraphQL backend
app/      Flutter client
```
