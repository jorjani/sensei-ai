# Source: Priorities

Reads a long-term priorities file for big-picture alignment checking.

## Config Keys

```yaml
sources:
  priorities:
    enabled: false
    file: ~/priorities.md
```

## How to Gather

Read the file specified in `file`. This should be a markdown file listing the user's quarterly or yearly priorities.

Expected format (flexible -- adapt to whatever structure the user has):

```markdown
# Priorities

1. **Priority name** -- description
2. **Priority name** -- description
3. **Priority name** -- description
```

## How to Present

List each priority found:

```
### Priorities (from ~/priorities.md)
- P1: Priority name -- description
- P2: Priority name -- description
```

The coach persona will use these to assess weekly alignment. If this source is disabled or the file doesn't exist, the coach should skip the Priorities Check section.

## Bootstrapping

If this source is enabled but the file doesn't exist, suggest the user create it. A good priorities file has:
- 3-5 priorities maximum
- Each has a clear success criterion
- Reviewed quarterly
