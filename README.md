# AI Coach

A Claude Code-powered personal coaching tool. Clone, configure, reflect.

Gathers data about your week (git commits, TODO files, priorities), then coaches you through a structured review using your chosen coaching persona.

**The entire system is markdown files. No code. Coaches and data sources are prompt fragments. Claude Code is the runtime.**

## Try It Now (5 minutes)

```bash
git clone <this-repo>
cd ai-coach

# Generate sample workspace with demo data
./scripts/demo-setup.sh

# Use the demo config
cp examples/config.demo.yaml config.yaml

# Run the review
claude
> /review
```

See [examples/sample-review.md](examples/sample-review.md) for example output.

## Your Own Setup

```bash
# Interactive setup -- detects your git repos and TODO files
claude
> /setup

# Or configure manually
cp config.example.yaml config.yaml
# Edit config.yaml with your paths
> /review
```

## Coaches

Each coach brings a different lens and voice to your weekly review.

- **Mochary** -- Matt Mochary's CEO coaching framework. Energy audit, "the one thing," fear check, commitment. Direct, no hedging, asks hard questions.
- **Grove** -- Andy Grove's High Output Management. Output inventory, bottleneck analysis, leverage audit. Ruthless about low-leverage work.
- **Any coach you want** -- Run `/add-coach Naval Ravikant` or `/add-coach "stoic philosophy"` to generate any persona.

Switch coaches in `config.yaml`:

```yaml
coach: grove   # or: mochary, naval-ravikant, etc.
```

## Data Sources

The coach gathers context about your week from pluggable sources:

| Source | What it reads | Config key |
|--------|--------------|------------|
| **Git Log** | Commit history from local repos | `sources.git-log` |
| **Markdown TODOs** | TODO.md files with goals and tasks | `sources.markdown-todos` |
| **Priorities** | Long-term priorities file | `sources.priorities` |
| **Calendar** | Meeting time vs focus time (macOS icalBuddy or .ics export) | `sources.calendar` |
| **GitHub** | PRs, issues, code reviews via `gh` CLI | `sources.github` |
| **Journal** | Dated markdown files from a journal directory | `sources.journal` |

More sources can be added by dropping a markdown file in `sources/`.

## Scheduling Automated Reviews

Run reviews automatically every Saturday morning. See [scripts/schedule/README.md](scripts/schedule/README.md).

## Adding Your Own Coach

The easiest way:

```
claude
> /add-coach Naval Ravikant
```

This generates a full coaching persona from Claude's knowledge of that person. Works with any name, philosophy, or style.

Or create one manually -- see [coaches/README.md](coaches/README.md) for the template.

## Adding a Data Source

Create a markdown file in `sources/` that describes:
1. What data to gather and how
2. What config keys it uses
3. How to present the gathered data

See [sources/README.md](sources/README.md) for the template.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed
- Git (for the git-log source)
