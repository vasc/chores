#!/bin/bash
# End-to-end smoke test of all major mutations.
# Assumes the server is already running at $URL.
set -euo pipefail
URL=${URL:-http://localhost:4000/graphql}

# Reset DB to a clean state
psql "${DATABASE_URL:-postgres://chores:chores@localhost:5432/chores}" -q -c '
  TRUNCATE redemptions, rewards, chore_assignments, chores, users, households RESTART IDENTITY CASCADE;
'

gql() {
  local query=$1
  local token=${2:-}
  if [ -n "$token" ]; then
    curl -sf -X POST "$URL" \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $token" \
      -d "{\"query\":$(jq -Rs . <<<"$query")}"
  else
    curl -sf -X POST "$URL" \
      -H "Content-Type: application/json" \
      -d "{\"query\":$(jq -Rs . <<<"$query")}"
  fi
}

echo "1. signUpHousehold"
SIGNUP=$(gql 'mutation { signUpHousehold(householdName:"Test", adultName:"Alice", email:"alice@example.com", password:"password123") { token user { id householdId: id } } }')
ADULT_TOKEN=$(echo "$SIGNUP" | jq -r '.data.signUpHousehold.token')
echo "  adult token: ${ADULT_TOKEN:0:20}..."

echo "2. addChild"
CHILD=$(gql 'mutation { addChild(name:"Sam", pin:"1234") { id name role } }' "$ADULT_TOKEN")
CHILD_ID=$(echo "$CHILD" | jq -r '.data.addChild.id')
echo "  child id: $CHILD_ID"

echo "3. createChore"
CHORE=$(gql 'mutation { createChore(title:"Dishes", tokenValue:5) { id title tokenValue } }' "$ADULT_TOKEN")
CHORE_ID=$(echo "$CHORE" | jq -r '.data.createChore.id')
echo "  chore id: $CHORE_ID"

echo "4. assignChore"
ASSIGN=$(gql "mutation { assignChore(choreId:\"$CHORE_ID\", assignedToUserId:\"$CHILD_ID\") { id status } }" "$ADULT_TOKEN")
ASSIGN_ID=$(echo "$ASSIGN" | jq -r '.data.assignChore.id')
echo "  assignment id: $ASSIGN_ID"

echo "5. kidLogin"
LOGIN=$(gql "mutation { kidLogin(userId:\"$CHILD_ID\", pin:\"1234\") { token user { id role tokenBalance } } }")
CHILD_TOKEN=$(echo "$LOGIN" | jq -r '.data.kidLogin.token')
echo "  kid token: ${CHILD_TOKEN:0:20}..."

echo "6. submitChore (as kid)"
gql "mutation { submitChore(assignmentId:\"$ASSIGN_ID\") { id status } }" "$CHILD_TOKEN" | jq -c '.data.submitChore'

echo "7. approveChore (as adult)"
gql "mutation { approveChore(assignmentId:\"$ASSIGN_ID\") { id status } }" "$ADULT_TOKEN" | jq -c '.data.approveChore'

echo "8. check kid balance"
ME=$(gql 'query { me { id name tokenBalance } }' "$CHILD_TOKEN")
echo "  $ME"
BAL=$(echo "$ME" | jq -r '.data.me.tokenBalance')
[ "$BAL" = "5" ] || { echo "❌ expected balance 5, got $BAL"; exit 1; }

echo "9. createReward"
REWARD=$(gql 'mutation { createReward(title:"Screen time 30min", tokenCost:5) { id tokenCost } }' "$ADULT_TOKEN")
REWARD_ID=$(echo "$REWARD" | jq -r '.data.createReward.id')
echo "  reward id: $REWARD_ID"

echo "10. requestRedemption (as kid)"
REDEEM=$(gql "mutation { requestRedemption(rewardId:\"$REWARD_ID\") { id status tokensSpent } }" "$CHILD_TOKEN")
REDEEM_ID=$(echo "$REDEEM" | jq -r '.data.requestRedemption.id')
echo "  $(echo "$REDEEM" | jq -c .data.requestRedemption)"

echo "11. approveRedemption (as adult)"
gql "mutation { approveRedemption(id:\"$REDEEM_ID\") { id status } }" "$ADULT_TOKEN" | jq -c '.data.approveRedemption'

echo "12. check kid balance debited"
BAL2=$(gql 'query { me { tokenBalance } }' "$CHILD_TOKEN" | jq -r '.data.me.tokenBalance')
[ "$BAL2" = "0" ] || { echo "❌ expected balance 0, got $BAL2"; exit 1; }
echo "  balance: $BAL2 ✓"

echo "13. fulfillRedemption"
gql "mutation { fulfillRedemption(id:\"$REDEEM_ID\") { id status } }" "$ADULT_TOKEN" | jq -c '.data.fulfillRedemption'

echo "14. on-demand chore: createChore kind=on_demand cooldownMinutes=60"
ONDEMAND=$(gql "mutation { createChore(title:\"Set table\", tokenValue:2, kind:on_demand, cooldownMinutes:60) { id kind cooldownMinutes } }" "$ADULT_TOKEN")
ONDEMAND_ID=$(echo "$ONDEMAND" | jq -r '.data.createChore.id')
echo "  $(echo "$ONDEMAND" | jq -c .data.createChore)"

echo "15. claimChore (kid → submitted)"
CLAIM=$(gql "mutation { claimChore(choreId:\"$ONDEMAND_ID\") { id status } }" "$CHILD_TOKEN")
CLAIM_ID=$(echo "$CLAIM" | jq -r '.data.claimChore.id')
[ "$(echo "$CLAIM" | jq -r '.data.claimChore.status')" = "submitted" ] || { echo "❌ expected submitted"; exit 1; }
echo "  $(echo "$CLAIM" | jq -c .data.claimChore)"

echo "16. double-claim → open-claim error"
ERR=$(gql "mutation { claimChore(choreId:\"$ONDEMAND_ID\") { id } }" "$CHILD_TOKEN" | jq -r '.errors[0].message')
[[ "$ERR" == *"open claim"* ]] || { echo "❌ expected open-claim error, got: $ERR"; exit 1; }
echo "  $ERR ✓"

echo "17. approveChore on the claim → kid balance += 2"
gql "mutation { approveChore(assignmentId:\"$CLAIM_ID\") { status } }" "$ADULT_TOKEN" | jq -c .data.approveChore
BAL3=$(gql 'query { me { tokenBalance } }' "$CHILD_TOKEN" | jq -r '.data.me.tokenBalance')
[ "$BAL3" = "2" ] || { echo "❌ expected balance 2, got $BAL3"; exit 1; }
echo "  balance: $BAL3 ✓"

echo "18. claim again immediately → cooldown error"
ERR=$(gql "mutation { claimChore(choreId:\"$ONDEMAND_ID\") { id } }" "$CHILD_TOKEN" | jq -r '.errors[0].message')
[[ "$ERR" == *"cooldown"* ]] || { echo "❌ expected cooldown error, got: $ERR"; exit 1; }
echo "  $ERR ✓"

echo "19. claim a scheduled chore → adult-only error"
ERR=$(gql "mutation { claimChore(choreId:\"$CHORE_ID\") { id } }" "$CHILD_TOKEN" | jq -r '.errors[0].message')
[[ "$ERR" == *"adult"* ]] || { echo "❌ expected adult-required error, got: $ERR"; exit 1; }
echo "  $ERR ✓"

echo
echo "✅ all green"
