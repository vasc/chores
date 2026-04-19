# Chore Tracker

Gamified household chore tracker with token rewards and adult-approved
completions. Multi-platform Flutter client talking to a Bun TypeScript
GraphQL backend.

**Platforms**: iOS · Android · macOS
**Stack**: Bun · GraphQL Yoga · Pothos · Kysely · Postgres · Flutter · Riverpod · graphql_flutter · graphql_codegen

---

## What it does

Adults create a household, add kids (protected by 4-digit PINs), and publish
**chores** worth some number of tokens. Kids see their assigned chores, mark
them done, and wait for an adult to approve. Approval credits tokens.

Adults also publish a **rewards catalog** (screen time, treats, allowance,
whatever) with token costs. Kids browse rewards and request redemptions.
An adult must approve the redemption (which debits the kid's balance) and
later mark it fulfilled.

Recurring chores (`daily` / `weekly`) auto-schedule the next assignment when
the current one is approved. A leaderboard ranks kids by token balance.

| Role | Can do |
|---|---|
| Adult | Everything: CRUD chores + rewards, assign, approve/reject chore submissions, approve/deny/fulfill redemptions, manage household members |
| Child | See their own assignments + household rewards, mark chores done, request redemptions, see own balance |

---

## Documentation

| Doc | What's in it |
|---|---|
| [`CLAUDE.md`](CLAUDE.md) | Codebase guidance for AI assistants and new contributors — repo layout, core workflows, gotchas |
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | System diagram, data flow, component responsibilities |
| [`docs/API.md`](docs/API.md) | GraphQL schema walkthrough with examples |
| [`docs/DEVELOPMENT.md`](docs/DEVELOPMENT.md) | Day-to-day dev workflow, debugging, testing |
| [`server/README.md`](server/README.md) | Backend-specific commands, env, migration workflow |
| [`app/README.md`](app/README.md) | Flutter app setup, platform-specific notes |

---

## Quick start

### Prerequisites

- **Bun** ≥ 1.1 — https://bun.sh
- **Postgres** ≥ 14 running locally (the init migration uses `pgcrypto` and `citext` extensions)
- **Flutter** ≥ 3.22 — https://docs.flutter.dev/get-started/install
- Platform toolchains for whatever target you'll run:
  - macOS app → Xcode
  - iOS → Xcode + a simulator
  - Android → Android Studio + an emulator

### 1. Create the database

```bash
createdb chores
createuser chores --pwprompt   # password: chores (or whatever you like)
psql -c "GRANT ALL PRIVILEGES ON DATABASE chores TO chores"
```

### 2. Server

```bash
cd server
bun install
cat > .env <<'EOF'
DATABASE_URL=postgres://chores:chores@localhost:5432/chores
JWT_SECRET=dev-secret-change-me-in-production
PORT=4000
EOF
bun run migrate
bun run dev          # GraphiQL: http://localhost:4000/graphql
```

### 3. Schema sync

Any time the server schema changes:

```bash
cd server
bun run sync         # writes ../app/lib/graphql/schema.graphql
```

### 4. Flutter app

```bash
cd app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d macos     # or -d ios / -d android
```

The app defaults to `http://localhost:4000/graphql`. Override with:

```bash
flutter run -d android --dart-define=API_URL=http://10.0.2.2:4000/graphql
flutter run --dart-define=API_URL=https://api.example.com/graphql
```

---

## End-to-end walkthrough

### Adult flow

1. **Sign up** — open the app, tap "I'm a parent" → "Create household".
   Enter household name, your name, email, password.
2. **Add a child** — Admin tab → Members → "Add child". Enter name, avatar
   emoji, 4-digit PIN.
3. **Create a chore** — Admin tab → Chores → "New chore". Title, token
   value, optional description, recurrence (`one_off` / `daily` / `weekly`).
4. **Assign it** — from the chore detail screen, pick a child and optional
   due date.
5. **Create a reward** — Admin tab → Rewards → "New reward". Title, token
   cost.
6. **Hand the device to the kid** — tap your avatar → "Switch to kid mode".

### Kid flow

1. **Kid picker** — tap your avatar.
2. **PIN** — enter your 4-digit PIN.
3. **Home** shows assigned chores. Tap one → "I did it" submits for approval.
4. **Rewards** tab browses available rewards. Tap "Redeem" (requires enough
   tokens).
5. **Back to parent** — tap the avatar → "Switch user".

### Adult follow-up

1. **Approvals** tab lists pending chore submissions and redemption
   requests.
2. **Approve** a chore → the kid's balance increases.
3. **Approve** a redemption → the kid's balance decreases; the redemption is
   now in the "approved" state. Mark it fulfilled once handed over.

### Recurring chore behavior

When you approve a chore whose recurrence is `daily` or `weekly`, the server
immediately creates the next `pending` assignment for the same kid, dated
+1 day or +7 days from the original due date. Duplicate spawns are skipped
if the kid already has an open (non-finalized) assignment for that chore.

---

## Repo layout

```
chores/
├── README.md, CLAUDE.md          Top-level docs
├── docs/                          Deeper docs (architecture, API, dev)
├── server/                        Bun + GraphQL + Postgres backend
└── app/                           Flutter client (iOS / Android / macOS)
```

See `CLAUDE.md` for the full file tree.

---

## Common issues

- **`bun run migrate` fails on extensions** — make sure your Postgres user
  has superuser or has `pgcrypto` and `citext` pre-installed at the database
  level.
- **Flutter app can't reach server on Android emulator** — the emulator
  sees the host as `10.0.2.2`, not `localhost`. Use
  `--dart-define=API_URL=http://10.0.2.2:4000/graphql`.
- **Flutter build fails with "schema mismatch"** — resync the server
  schema: `cd server && bun run sync`, then
  `dart run build_runner build --delete-conflicting-outputs` in `app/`.
- **macOS app can't reach the server** — verify
  `com.apple.security.network.client` is in both
  `app/macos/Runner/DebugProfile.entitlements` and
  `app/macos/Runner/Release.entitlements`.
- **iOS simulator refuses HTTP** — `NSAllowsLocalNetworking` is set in
  `app/ios/Runner/Info.plist`. If you point `API_URL` at a non-local
  hostname, you need HTTPS.

---

## License

Unlicensed / private. Adjust before publishing.
