# Source: Markdown TODOs

Reads local TODO and goals files for current status and recent completions.

## Config Keys

```yaml
sources:
  markdown-todos:
    enabled: true
    files:                # Specific files to read
      - ~/TODO.md
    glob: "*/TODO.md"     # Also scan for project TODOs (relative to git-log paths)
```

## How to Gather

1. Read each file listed in `files` (expand `~` to home directory).
2. If `glob` is set and `git-log.paths` is configured, scan those directories for matching files.
3. For each file found, extract:
   - **Goals section:** Look for headings like "Goals", "This Week", "Objectives"
   - **Open items:** Unchecked boxes `- [ ]` or plain bullet items under task headings
   - **Completed items:** Checked boxes `- [x]` (especially recent ones)
   - **Done/Archive section:** Look for "Done", "Completed", "Archive" headings

## How to Present

Group by file. For each file with content:

```
### ~/TODO.md
**Goals:** [list if found]
**Open:** [count] items
**Completed this period:** [list of checked items]
```

If a file doesn't exist, note it and move on (don't error).
