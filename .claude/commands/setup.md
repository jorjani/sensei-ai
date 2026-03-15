# /setup -- First-Run Configuration

Help the user set up their AI Coach by creating a `config.yaml`.

---

## Your Task

Walk the user through configuration interactively. Ask one question at a time.

### Step 1: Work Directories

Ask: "Where does your work live? (e.g., ~/Projects, ~/Code, ~/work)"

Auto-detect: Check common locations (`~/Projects`, `~/Code`, `~/Developer`, `~/work`, `~/src`) for directories that exist. Suggest any that are found.

### Step 2: Scan for Git Repos

Scan the selected directories for git repos (look for `.git` in direct children).

Show what was found:
```
Found N git repos in ~/Projects:
  - repo-a (last commit: 2 days ago)
  - repo-b (last commit: today)
  - repo-c (last commit: 3 weeks ago)
```

Ask if these look right, or if they want to adjust paths/depth.

### Step 3: TODO Files

Ask: "Do you keep TODO or goals files? If so, where?"

Also check if any `TODO.md` files exist in the scanned repos. Show what was found.

If the user doesn't have TODO files, that's fine -- disable the `markdown-todos` source.

### Step 4: Priorities

Ask: "Do you have a long-term priorities file (quarterly/yearly goals)? This helps the coach assess whether your weekly work aligns with what matters most."

If yes, get the path. If no, suggest creating one later and disable the source for now.

### Step 5: Coach Selection

Explain available coaches:
- **Mochary** -- Direct, no-nonsense coaching. Energy audit, "the one thing," fear check, commitment. Based on Matt Mochary's CEO coaching framework.

(Only Mochary is available now. More coaches coming: Andreessen, Elon, Jobs.)

### Step 6: Generate Config

Write `config.yaml` with the user's choices. Show them the generated config and confirm.

### Step 7: First Review

Ask if they want to run their first review now: "Run `/review` to try it out."

---

## Rules

- One question at a time. Don't dump all questions at once.
- Use sensible defaults -- don't ask about things that have obvious answers.
- If a directory doesn't exist, don't include it.
- The generated config should be clean and commented.

$ARGUMENTS
