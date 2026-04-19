# chores-server

Bun + TypeScript + GraphQL Yoga + Pothos + Kysely + Postgres.

For the big picture, see [`../README.md`](../README.md),
[`../CLAUDE.md`](../CLAUDE.md), and [`../docs/`](../docs/).

## Commands

| Command | What it does |
|---|---|
| `bun install` | Install dependencies |
| `bun run dev` | Start the server with file watching (http://localhost:4000/graphql) |
| `bun run start` | Start the server without watching |
| `bun run typecheck` | `tsc --noEmit` |
| `bun run migrate` | Apply pending migrations |
| `bun run migrate:down` | Roll back the latest migration |
| `bun run db:types` | Introspect the live DB and rewrite `src/db/generated.ts` |
| `bun run db:types:verify` | Fail if `src/db/generated.ts` is out of date (CI) |
| `bun run schema` | Print the Pothos schema to `schema.graphql` |
| `bun run sync` | `schema` + copy to `../app/lib/graphql/schema.graphql` |

## Environment

Copy `.env.example` or create `.env`:

```env
DATABASE_URL=postgres://chores:chores@localhost:5432/chores
JWT_SECRET=dev-secret-change-me-in-production
PORT=4000
```

All vars are validated in `src/env.ts` via Zod; the server fails fast on
missing / malformed values.

## Layout

```
server/
├── package.json
├── tsconfig.json
├── schema.graphql            Generated SDL (committed)
├── scripts/
│   └── e2e.sh                End-to-end smoke test
└── src/
    ├── index.ts              Bun.serve + Yoga handler
    ├── env.ts                Env schema
    ├── context.ts            Per-request context + auth helpers
    ├── db/
    │   ├── kysely.ts         PG pool + Kysely instance
    │   ├── generated.ts      kysely-codegen output (committed; `bun run db:types`)
    │   ├── migrate.ts        Migration CLI
    │   └── migrations/
    │       └── 0001_init.ts  Initial schema
    ├── auth/
    │   ├── jwt.ts            sign/verify via jose
    │   ├── password.ts       bcrypt adult password
    │   └── pin.ts            bcrypt kid PIN
    └── schema/
        ├── builder.ts        Pothos + plugins + scalars
        ├── enums.ts          GraphQL enums
        ├── types.ts          Object type refs
        ├── queries.ts        Root Query resolvers
        ├── auth.ts           Auth mutations
        ├── chores.ts         Chore + assignment mutations
        ├── rewards.ts        Reward + redemption mutations
        ├── print.ts          `bun run schema` entry
        └── index.ts          Assembles schema
```

## Migrations

Migrations live in `src/db/migrations/` as sequentially-numbered TS
files. Each exports `up` and `down` functions that take a
`Kysely<unknown>` and apply changes.

```bash
bun run migrate          # apply pending
bun run migrate:down     # rollback latest
```

**Never edit a migration that has been applied.** Add a new one.

After changing the DB shape, run `bun run db:types` to regenerate
`src/db/generated.ts` from the live Postgres schema. Commit the
regenerated file alongside the migration. CI's `bun run db:types:verify`
fails if the committed file is out of date.

## End-to-end test

`scripts/e2e.sh` drives the API with curl + jq. It creates a household,
child, chore, assignment, and reward, then walks the full
submit→approve→redeem→approve cycle. It also verifies the recurring-chore
spawn.

Run it with a running server and a live database:

```bash
bun run dev &
sleep 2
DATABASE_URL=postgres://chores:chores@localhost:5432/chores bash scripts/e2e.sh
```

It exits non-zero on any failure. Extend it whenever adding a new flow.

## Deployment notes

- Build for production: Bun executes TS natively, so you can deploy the
  source directly. `bun run start` runs without watching.
- Behind a reverse proxy for TLS; the server itself speaks plain HTTP.
- Set a strong `JWT_SECRET` (≥32 random bytes) and a production
  `DATABASE_URL` with SSL.
- Consider a PgBouncer in front of Postgres if scaling to many clients.
