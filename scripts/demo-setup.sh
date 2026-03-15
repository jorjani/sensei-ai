#!/bin/bash
# Creates a demo workspace with sample git repos, TODOs, and priorities.
# Simulates a founder's week -- the classic "hiding in code instead of
# talking to customers" pattern that every coach would catch.
#
# Idempotent -- wipes and recreates the demo workspace each run.
#
# Usage:
#   ./scripts/demo-setup.sh              # Default: ./examples/demo-workspace
#   ./scripts/demo-setup.sh ~/my-demo    # Custom target directory

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET="${1:-$REPO_ROOT/examples/demo-workspace}"

echo "Setting up demo workspace at: $TARGET"

# Clean slate
rm -rf "$TARGET"
mkdir -p "$TARGET"

# Calculate dates relative to today (works on both macOS and Linux)
date_ago() {
  local days_ago=$1
  if date --version &>/dev/null 2>&1; then
    date -d "$days_ago days ago" "+%Y-%m-%dT%H:%M:%S"
  else
    date -v-"${days_ago}"d "+%Y-%m-%dT%H:%M:%S"
  fi
}

MONDAY=$(date -v-"$(( ($(date +%u) - 1) ))"d "+%B %d" 2>/dev/null || date -d "last Monday" "+%B %d")

# ─── Root TODO.md ──────────────────────────────────────────────

cat > "$TARGET/TODO.md" << 'TODOEOF'
# Weekly Plan

## Goals -- Week of WEEK_PLACEHOLDER

1. [ ] Have 5 customer discovery calls (validate pricing model)
2. [x] Fix the billing bug blocking Acme Corp renewal
3. [ ] Ship self-serve onboarding so new users don't need a demo call
4. [ ] Publish the "Lessons from our first 10 customers" blog post
5. [ ] Send March investor update (two weeks overdue)
6. [ ] Follow up with 3 warm intro leads from Sarah

## Open Items

### Product
- [ ] Onboarding flow: users still need a 30-min call to get started
- [ ] Pricing page: need to finalize tiers based on customer feedback
- [x] Billing bug: Acme Corp was getting charged for archived users
- [x] Dashboard export: added CSV export (customer request)

### Internal tools
- [x] Built a Slack bot for customer health scoring
- [x] Set up automated usage analytics pipeline
- [x] Refactored the admin dashboard with better filters
- [x] Added internal metrics page for weekly KPIs

### Content
- [ ] Blog draft at 400 words, needs customer quotes
- [ ] LinkedIn post series planned but not started

## Done (Last Week)
- [x] Closed Acme Corp renewal ($2,400/mo ARR)
- [x] Ran 2 customer discovery calls (target was 5)
- [x] Set up PostHog analytics
TODOEOF

if command -v sed &>/dev/null; then
  sed -i.bak "s/WEEK_PLACEHOLDER/$MONDAY/" "$TARGET/TODO.md" && rm -f "$TARGET/TODO.md.bak"
fi

# ─── Priorities ────────────────────────────────────────────────

cat > "$TARGET/priorities.md" << 'EOF'
# Priorities (Q1 2026)

1. **Find product-market fit** -- Talk to 20 more customers this quarter. Validate pricing, understand churn reasons, identify the "hair on fire" use case. Nothing else matters if we're building the wrong thing.

2. **Get to $10k MRR** -- Currently at $4.2k. Need self-serve onboarding and a working pricing page to remove founder-as-bottleneck from sales. Every new customer currently requires a personal demo call.

3. **Build an audience** -- Publish weekly, grow LinkedIn to 2k followers. The blog and social posts are top-of-funnel for inbound leads. Two of our current customers found us through a LinkedIn post.

4. **Maintain investor trust** -- Monthly updates, be transparent about metrics and burn rate. Next raise conversation starts in Q2 if we hit $10k MRR.
EOF

# ─── product (main repo, some commits but all reactive) ───────

mkdir -p "$TARGET/product"
cd "$TARGET/product"
git init -q

cat > TODO.md << 'EOF'
# Product

## This Sprint
- [ ] Self-serve onboarding flow
- [ ] Pricing page with tier comparison
- [x] Fix billing bug (Acme Corp)
- [x] CSV export for dashboard

## Backlog
- [ ] Team invitation flow
- [ ] Usage-based billing support
- [ ] API for partner integrations
EOF

cat > README.md << 'EOF'
# Product
B2B workflow automation for operations teams.
EOF

git add -A && GIT_AUTHOR_DATE="$(date_ago 6)" GIT_COMMITTER_DATE="$(date_ago 6)" git commit -q -m "fix: billing calculation excluding archived users

Acme Corp was being charged for users they had archived.
Updated billing query to filter by active status."

cat > export.js << 'EOF'
export async function exportToCsv(orgId, dateRange) {
  const data = await db.query(
    'SELECT * FROM metrics WHERE org_id = $1 AND created_at BETWEEN $2 AND $3',
    [orgId, dateRange.start, dateRange.end]
  );
  return formatCsv(data);
}
EOF

git add -A && GIT_AUTHOR_DATE="$(date_ago 5)" GIT_COMMITTER_DATE="$(date_ago 5)" git commit -q -m "feat: add CSV export to dashboard

Customer request from Acme Corp. Export filtered metrics
to CSV with date range selection."

# ─── internal-tools (where all the time went) ─────────────────

mkdir -p "$TARGET/internal-tools"
cd "$TARGET/internal-tools"
git init -q

cat > TODO.md << 'EOF'
# Internal Tools

## Done This Week
- [x] Slack bot for customer health scores
- [x] Usage analytics pipeline
- [x] Admin dashboard redesign
- [x] Internal KPI metrics page

## Next
- [ ] Automated churn risk alerts
- [ ] Revenue forecasting dashboard
- [ ] Customer onboarding tracker
EOF

cat > README.md << 'EOF'
# Internal Tools
Internal dashboards and automations.
EOF

git add -A && GIT_AUTHOR_DATE="$(date_ago 6)" GIT_COMMITTER_DATE="$(date_ago 6)" git commit -q -m "feat: Slack bot for customer health scoring

Pulls usage data from PostHog, calculates health score,
posts daily summary to #customer-health channel."

echo "// analytics pipeline" > pipeline.js
git add -A && GIT_AUTHOR_DATE="$(date_ago 5)" GIT_COMMITTER_DATE="$(date_ago 5)" git commit -q -m "feat: automated usage analytics pipeline

Aggregates daily active users, feature usage, and session
duration into a Postgres table for internal reporting."

echo "// admin dashboard" > admin.js
git add -A && GIT_AUTHOR_DATE="$(date_ago 4)" GIT_COMMITTER_DATE="$(date_ago 4)" git commit -q -m "refactor: redesign admin dashboard with better filters

Added date range picker, customer search, and sortable columns.
Much easier to find specific customer data now."

echo "// admin styles" > admin.css
git add -A && GIT_AUTHOR_DATE="$(date_ago 4)" GIT_COMMITTER_DATE="$(date_ago 4)" git commit -q -m "style: polish admin dashboard layout and responsive design"

echo "// kpi metrics" > kpi.js
git add -A && GIT_AUTHOR_DATE="$(date_ago 3)" GIT_COMMITTER_DATE="$(date_ago 3)" git commit -q -m "feat: internal KPI metrics page

Weekly MRR, churn rate, NPS, and customer count.
Auto-refreshes every hour."

echo "// chart components" > charts.js
git add -A && GIT_AUTHOR_DATE="$(date_ago 3)" GIT_COMMITTER_DATE="$(date_ago 3)" git commit -q -m "feat: add trend charts to KPI dashboard

Line charts for MRR growth and bar charts for feature adoption.
Using Recharts for visualization."

echo "// alerts config" > alerts.js
git add -A && GIT_AUTHOR_DATE="$(date_ago 2)" GIT_COMMITTER_DATE="$(date_ago 2)" git commit -q -m "feat: configurable alert thresholds for health scores

Admins can set custom thresholds for health score alerts.
Defaults to warning at 60, critical at 40."

echo "// tests" > test.js
git add -A && GIT_AUTHOR_DATE="$(date_ago 1)" GIT_COMMITTER_DATE="$(date_ago 1)" git commit -q -m "test: add health score calculation and pipeline tests"

# ─── content (barely touched) ─────────────────────────────────

mkdir -p "$TARGET/content/drafts"
cd "$TARGET/content"
git init -q

cat > "drafts/lessons-first-10-customers.md" << 'EOF'
# Lessons from Our First 10 Customers

We hit 10 paying customers last month. Here's what surprised us.

## 1. They don't care about features

Every customer we talked to cared about one thing: does this save me time
on Friday reporting? Not integrations, not dashboards, not API access.

(TODO: add the other lessons, get quotes from 3 customers)
EOF

git add -A && GIT_AUTHOR_DATE="$(date_ago 5)" GIT_COMMITTER_DATE="$(date_ago 5)" git commit -q -m "draft: start lessons from first 10 customers post

About 400 words. Need to interview 3 customers for quotes
and finish the remaining sections."

# ─── Done ──────────────────────────────────────────────────────

cd "$REPO_ROOT"

echo ""
echo "Demo workspace created at: $TARGET"
echo ""
echo "  product/         2 commits (bug fix + customer request, reactive)"
echo "  internal-tools/  8 commits (dashboards, analytics, Slack bot)"
echo "  content/         1 commit  (blog draft started, not finished)"
echo ""
echo "The story: Founder says 'talk to customers' is priority #1"
echo "but spent 70% of the week building internal tools."
echo ""
echo "Next steps:"
echo "  cp examples/config.demo.yaml config.yaml"
echo "  claude"
echo "  /review"
