# Writing a Custom Source

A source adapter is a markdown file that tells Claude how to gather data. No code required.

## Template

Create a file in `sources/` with this structure:

```markdown
# Source: Your Source Name

One-line description of what this source provides.

## Config Keys

Show the YAML config block users add to `config.yaml`:

    sources:
      your-source:
        enabled: true
        key: value

## How to Gather

Step-by-step instructions for Claude to collect data. Include:
- Bash commands to run (if any)
- Files to read
- APIs to call (if available via CLI)
- How to handle missing data gracefully

## How to Present

Describe the output format. The coach persona will use this
data to structure the review.
```

## Built-in Sources

| Source | File | What it gathers |
|--------|------|-----------------|
| Git Log | `git-log.md` | Commit history from local repos |
| Markdown TODOs | `markdown-todos.md` | Goals, open items, completed tasks |
| Priorities | `priorities.md` | Long-term priorities file |
| Calendar | `calendar.md` | Meeting time vs focus time (icalBuddy or .ics) |
| GitHub | `github.md` | PRs, issues, reviews via `gh` CLI |
| Journal | `journal.md` | Dated markdown files from a journal directory |

## Ideas for More Sources

- **Linear/Jira** -- Use CLI tools to pull sprint data
- **Time tracking** -- Read exports from Toggl, Clockify, etc.
- **Slack** -- Summarize channel activity or DMs
- **Email** -- Meeting invites and follow-up threads
