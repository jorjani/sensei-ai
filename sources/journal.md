# Source: Journal

Reads dated markdown files from a journal directory. Many developers keep a daily log -- this surfaces those entries for the coach.

## Config Keys

```yaml
sources:
  journal:
    enabled: true
    path: ~/journal           # Directory with dated markdown files
    pattern: "YYYY-MM-DD"     # Date pattern in filenames
```

## How to Gather

1. Expand `~` in `path` to home directory.
2. Look for markdown files matching date patterns from the target week. Common naming conventions to check:
   - `YYYY-MM-DD.md` (e.g., `2026-03-15.md`)
   - `YYYY-MM-DD-*.md` (e.g., `2026-03-15-standup.md`)
   - `YYYY/MM-DD.md` (nested by year)
   - `MM-DD-YYYY.md`

3. For each file found within the date range, read its contents.

4. If no files match, check if the directory exists:
   - Directory doesn't exist: "Journal source enabled but directory not found at {path}."
   - Directory exists but no files match: "No journal entries found for this week in {path}."

## How to Present

Show entries chronologically:

```
### Journal (last 7 days)

**Monday (Mar 10):**
> Felt productive. Knocked out the billing fix in the morning.
> Spent afternoon on the Slack bot -- probably should have worked on onboarding instead.

**Wednesday (Mar 12):**
> Customer call cancelled. Used the time to refactor the admin dashboard.
> Need to reschedule -- avoiding it?

**Friday (Mar 14):**
> Week felt busy but not sure what actually moved forward.
```

Use blockquotes for journal content. If entries are long (>500 words), summarize key themes and mood. The coach will use these for energy and pattern analysis.
