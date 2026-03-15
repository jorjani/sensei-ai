# Source: Git Log

Gathers recent commit history from local git repositories.

## Config Keys

```yaml
sources:
  git-log:
    enabled: true
    paths:
      - ~/Projects       # Directories to scan for git repos
    depth: 1              # 1 = direct children only, 2 = two levels deep
    days: 7               # How far back to look
```

## How to Gather

1. For each directory in `paths`, find git repositories up to `depth` levels deep.
   - `depth: 1` means look for `.git` in direct children (e.g., `~/Projects/my-app/.git`)
   - `depth: 2` means also check grandchildren

2. For each git repo found, run:
   ```bash
   git -C <repo_path> log --oneline --since="<days> days ago" --author="$(git -C <repo_path> config user.name)" --no-merges
   ```

3. Also check for uncommitted work:
   ```bash
   git -C <repo_path> diff --stat HEAD
   ```

## How to Present

Group commits by repository name. For each repo with activity:

```
### repo-name (N commits)
- commit message 1
- commit message 2
- [+ uncommitted changes in X files]
```

Skip repos with zero commits and no uncommitted changes.

Sort repos by number of commits (most active first).
