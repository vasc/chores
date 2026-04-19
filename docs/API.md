# GraphQL API

The server exposes a single GraphQL endpoint at `/graphql`. In development
mode it also serves GraphiQL at the same path (open
`http://localhost:4000/graphql` in a browser).

Authentication: `Authorization: Bearer <JWT>` header on every authenticated
request. Obtain a JWT via `signUpHousehold`, `loginAdult`, or `kidLogin`.

The canonical SDL is in [`server/schema.graphql`](../server/schema.graphql).

## Scalars

- `ID` — GraphQL ID (serialized as string).
- `UUID` — UUID string, validated on input.
- `DateTime` — ISO-8601 UTC datetime, e.g. `2026-04-19T20:15:30Z`.

## Enums

| Enum | Values |
|---|---|
| `Role` | `adult`, `child` |
| `Recurrence` | `one_off`, `daily`, `weekly` |
| `ChoreStatus` | `pending`, `submitted`, `approved`, `rejected` |
| `RedemptionStatus` | `requested`, `approved`, `denied`, `fulfilled` |

## Types

```graphql
type Household {
  id: ID!
  name: String!
  createdAt: DateTime!
}

type User {
  id: ID!
  householdId: UUID!
  name: String!
  role: Role!
  email: String        # adults only
  avatarEmoji: String!
  tokenBalance: Int!
  createdAt: DateTime!
}

type Chore {
  id: ID!
  title: String!
  description: String
  tokenValue: Int!
  recurrence: Recurrence!
  archived: Boolean!
  createdBy: User!
  createdAt: DateTime!
}

type ChoreAssignment {
  id: ID!
  chore: Chore!
  assignedTo: User!
  dueDate: DateTime
  status: ChoreStatus!
  submittedAt: DateTime
  approvedAt: DateTime
  rejectReason: String
  createdAt: DateTime!
}

type Reward {
  id: ID!
  title: String!
  description: String
  tokenCost: Int!
  archived: Boolean!
  createdAt: DateTime!
}

type Redemption {
  id: ID!
  reward: Reward!
  user: User!
  tokensSpent: Int!
  status: RedemptionStatus!
  requestedAt: DateTime!
  decidedAt: DateTime
  decisionReason: String
}

type AuthPayload {
  token: String!
  user: User!
}
```

## Queries

### `me: User`

Returns the authenticated user or `null` if unauth.

```graphql
query Me {
  me {
    id
    name
    role
    tokenBalance
    householdId
  }
}
```

### `household: Household!`

Returns the viewer's household.

### `members: [User!]!`

All members of the viewer's household. Adults and children.

### `leaderboard: [User!]!`

Kids in the household sorted by `tokenBalance` descending. Used for the
admin members tab.

### `chores(includeArchived: Boolean = false): [Chore!]!`

All chore templates in the household. Set `includeArchived: true` to see
retired chores.

### `assignments(mineOnly: Boolean = false, status: ChoreStatus): [ChoreAssignment!]!`

Chore assignments. Kids typically pass `mineOnly: true`. Optional
`status` filter.

```graphql
query MyOpenAssignments {
  assignments(mineOnly: true, status: pending) {
    id
    dueDate
    chore { title tokenValue }
  }
}
```

### `pendingApprovals: [ChoreAssignment!]!`

Shortcut for adults: all chore assignments in state `submitted`.

### `rewards(includeArchived: Boolean = false): [Reward!]!`

Rewards catalog.

### `redemptions(mineOnly: Boolean = false, status: RedemptionStatus): [Redemption!]!`

Redemption history. Kids pass `mineOnly: true`.

### `pendingRedemptions: [Redemption!]!`

Shortcut: redemptions in state `requested`.

### `kidsForLogin(householdId: UUID!): [User!]!`

**Public** (no auth). Returns the household's children so the kid picker
can render. Only `id`, `name`, `avatarEmoji` are meaningful here.

## Mutations

### Auth

#### `signUpHousehold(householdName, adultName, email, password): AuthPayload!`

Creates a new household and an adult member. Returns a 30-day JWT.

```graphql
mutation SignUp($h: String!, $n: String!, $e: String!, $p: String!) {
  signUpHousehold(
    householdName: $h
    adultName: $n
    email: $e
    password: $p
  ) {
    token
    user { id name role }
  }
}
```

#### `loginAdult(email, password): AuthPayload!`

Email + password login for adults. Returns a 30-day JWT.

#### `kidLogin(userId, pin): AuthPayload!`

PIN-based login for a child. Requires the kid's user ID (obtained from
`kidsForLogin`) and their 4-digit PIN. Returns an 8-hour JWT.

#### `addChild(name, pin, avatarEmoji): User!`  *(adult only)*

Add a child to the household.

#### `addAdult(name, email, password): User!`  *(adult only)*

Add another adult to the household.

#### `updateChildPin(userId, newPin): User!`  *(adult only)*

Reset a kid's PIN.

### Chores

#### `createChore(title, description?, tokenValue, recurrence = one_off): Chore!`  *(adult only)*

Create a chore template.

#### `updateChore(id, title?, description?, tokenValue?, recurrence?): Chore!`  *(adult only)*

Update a chore template.

#### `archiveChore(id): Chore!`  *(adult only)*

Soft-delete a chore. Existing assignments are unaffected; new
assignments can't be created and recurring spawn is skipped.

#### `assignChore(choreId, assignedToUserId, dueDate?): ChoreAssignment!`  *(adult only)*

Create a chore assignment for a specific user.

#### `submitChore(assignmentId): ChoreAssignment!`  *(authenticated)*

Kid marks their assignment as done. Transitions `pending → submitted`
(or `rejected → submitted`).

#### `approveChore(assignmentId): ChoreAssignment!`  *(adult only)*

Approve a submission. Transitions `submitted → approved` (also accepts
`pending → approved` for direct credit). Credits
`chore.tokenValue` to the kid's balance inside a transaction. If the
chore is `daily`/`weekly`, automatically schedules the next assignment.

#### `rejectChore(assignmentId, reason?): ChoreAssignment!`  *(adult only)*

Reject a submission. Transitions `submitted → rejected`. No tokens
credited. Kid can resubmit.

### Rewards

#### `createReward(title, description?, tokenCost): Reward!`  *(adult only)*

Create a reward in the catalog.

#### `updateReward(id, title?, description?, tokenCost?): Reward!`  *(adult only)*

Update a reward.

#### `archiveReward(id): Reward!`  *(adult only)*

Soft-delete. Existing redemptions unaffected.

#### `requestRedemption(rewardId): Redemption!`  *(authenticated)*

Kid requests a reward. Requires `tokenBalance >= tokenCost`. Creates a
redemption in state `requested`. **Balance is not debited yet.**

#### `approveRedemption(id): Redemption!`  *(adult only)*

Approve a redemption. Transitions `requested → approved` and atomically
debits the kid's balance.

#### `denyRedemption(id, reason?): Redemption!`  *(adult only)*

Deny a redemption. Transitions `requested → denied`. No debit.

#### `fulfillRedemption(id): Redemption!`  *(adult only)*

Mark a previously-approved redemption as delivered (e.g., the kid got
their screen time). Transitions `approved → fulfilled`.

## Error shapes

Resolvers throw plain `Error` instances, which graphql-yoga serializes into
the standard `errors[]` response shape:

```json
{
  "errors": [
    { "message": "Insufficient balance", "path": ["requestRedemption"] }
  ],
  "data": null
}
```

Common messages the client special-cases in `prettifyError`:

- `"Invalid credentials"` — wrong email/password or PIN.
- `"Insufficient balance"` — kid tried to redeem a reward they can't afford.
- `"Already approved"` — double-approve race.
- `"Cannot submit a chore that is approved"` — client sent a stale state.

## Typical adult session

```graphql
# 1. Log in
mutation { loginAdult(email: "a@b.com", password: "…") { token } }

# 2. Glance at pending work
query { pendingApprovals { id chore { title } assignedTo { name } }
        pendingRedemptions { id reward { title } user { name } } }

# 3. Approve a chore
mutation { approveChore(assignmentId: "…") { status } }

# 4. Approve a redemption
mutation { approveRedemption(id: "…") { status user { tokenBalance } } }
```

## Typical kid session

```graphql
# 1. Public list of kids for the picker
query($h: UUID!) { kidsForLogin(householdId: $h) {
  id name avatarEmoji
} }

# 2. Log in with PIN
mutation { kidLogin(userId: "…", pin: "1234") { token user { id } } }

# 3. See my chores
query { assignments(mineOnly: true) {
  id status chore { title tokenValue }
} }

# 4. Mark one done
mutation { submitChore(assignmentId: "…") { status } }

# 5. Browse rewards and redeem
query { rewards { id title tokenCost }
        me { tokenBalance } }
mutation { requestRedemption(rewardId: "…") { status tokensSpent } }
```
