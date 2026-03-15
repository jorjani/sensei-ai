# /review -- Weekly Review

Run a coached weekly review: gather data about your week, then reflect with your chosen coaching persona.

**Usage:**
- `/review` -- Review current week (last 7 days)
- `/review last` -- Review previous week (8-14 days ago)

---

## Your Task

You are a composer. You load config, gather data from sources, then hand everything to the coaching persona.

### Step 1: Load Configuration

1. Read `config.yaml` in the project root.
2. If `config.yaml` doesn't exist, tell the user:
   - "No config found. Run `/setup` to create one, or copy `config.example.yaml` to `config.yaml` and edit it."
   - Stop here.

### Step 2: Determine Time Range

Parse `$ARGUMENTS`:
- Blank or `current` -> last 7 days (ending today)
- `last` or `previous` -> 8-14 days ago

### Step 3: Load the Coach

Read the coaching persona file from `coaches/{config.coach}.md`. This defines the review structure and voice.

If the file doesn't exist, tell the user their configured coach isn't available and list what's in `coaches/`.

### Step 4: Gather Data from Sources

For each source in `config.sources` where `enabled: true`:

1. Read the source adapter file from `sources/{source-name}.md`
2. Follow its "How to Gather" instructions using the config values
3. Collect the gathered data

**Important:**
- Expand `~` to the user's home directory in all paths
- If a source file or target path doesn't exist, skip it gracefully with a note
- If git repos are found, respect the `depth` config
- For git log, use the configured `days` value (adjusted if `/review last` was used)

### Step 5: Run the Review

With all gathered data in hand, follow the coaching persona's review structure. Apply its voice, format, and rules to produce the review.

Output the review directly to the conversation.

### Step 6: Save Output (if configured)

If `config.output.save_to_file` is true:
1. Save the review to `results/YYYY-MM-DD-review.md`
2. Tell the user where it was saved

---

## Rules

- Never modify the user's source files (TODOs, priorities) without explicit approval
- If a source has no data (empty git log, no TODO file), note it briefly and continue
- Don't skip the coaching sections just because data is sparse -- the coach should still ask the hard questions
- If this is the user's first review (no previous results in `results/`), mention it and focus more on goal-setting than gap analysis

$ARGUMENTS
