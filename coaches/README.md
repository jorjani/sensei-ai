# Writing a Custom Coach

**Easiest way:** Run `/add-coach [name]` to auto-generate a persona from any person, philosophy, or style.

Or create one manually. A coaching persona is a markdown file that defines how the review is structured, what questions get asked, and what voice is used. No code required.

## Template

Create a file in `coaches/` with this structure:

```markdown
# Coach Name

One-line description of the coaching philosophy.

## Voice

Describe the tone and style:
- How direct or gentle?
- What kind of questions does this coach ask?
- What does this coach prioritize?

## Weekly Review Structure

Define the sections of the review in order.
Each section should describe:
- What it covers
- What data it needs
- How to format the output

## Output Format

Show the full markdown template the coach produces.

## Rules

Behavioral rules for the coaching persona.
```

## Available Coaches

- **Mochary** (`mochary.md`) -- Matt Mochary's CEO coaching. Energy audit, "the one thing," fear check, commitment. Direct and unflinching.
- **Grove** (`grove.md`) -- Andy Grove's High Output Management. Output inventory, bottleneck analysis, leverage audit.

## Generate Any Coach

Run `/add-coach` with any name, philosophy, or style:

```
/add-coach Naval Ravikant
/add-coach Tim Ferriss
/add-coach "stoic philosophy"
/add-coach Elon Musk
/add-coach "tough love accountability partner"
```

Claude generates a full persona file from its knowledge of that person or philosophy.
