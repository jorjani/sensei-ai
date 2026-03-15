# Source: GitHub

Pulls contribution activity using the `gh` CLI: PRs, issues, and code reviews.

## Config Keys

```yaml
sources:
  github:
    enabled: true
    repos: []           # Specific repos (owner/repo). Empty = all repos you contributed to
    days: 7
```

## How to Gather

Requires `gh` CLI authenticated (`gh auth status`). If not available or not authenticated, note it and skip.

**PRs authored:**
```bash
gh search prs --author=@me --created=">$(date -v-7d +%Y-%m-%d)" --json title,repository,state,url,createdAt,closedAt --limit 50
```

**PRs reviewed:**
```bash
gh search prs --reviewed-by=@me --updated=">$(date -v-7d +%Y-%m-%d)" --json title,repository,state,url --limit 50
```

**Issues authored or assigned:**
```bash
gh search issues --author=@me --created=">$(date -v-7d +%Y-%m-%d)" --json title,repository,state,url --limit 50
gh search issues --assignee=@me --updated=">$(date -v-7d +%Y-%m-%d)" --json title,repository,state,url --limit 50
```

If `repos` is set in config, filter results to only those repos. If empty, show all.

For Linux, replace `-v-7d` with `-d "7 days ago"` in date commands.

## How to Present

```
### GitHub (last 7 days)

**PRs authored:** 3 (2 merged, 1 open)
- [Merged] repo-name: "Add user onboarding flow" (#42)
- [Merged] repo-name: "Fix billing calculation" (#38)
- [Open] repo-name: "API rate limiting" (#45)

**PRs reviewed:** 2
- repo-name: "Update pricing page" (#41) -- approved
- repo-name: "Refactor auth middleware" (#39) -- changes requested

**Issues:** 1 opened, 3 closed
- [Closed] repo-name: "Dashboard export broken" (#36)
- [Closed] repo-name: "Webhook retry failures" (#33)
- [Closed] repo-name: "Customer reported slow loads" (#31)
- [Opened] repo-name: "Plan team invitation flow" (#44)
```

Group by repo if multiple repos are active. Skip sections with zero activity.
