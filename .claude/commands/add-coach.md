# /add-coach -- Generate a Coaching Persona

Create a new coaching persona from any person, philosophy, or style.

**Usage:**
- `/add-coach Naval Ravikant`
- `/add-coach Tim Ferriss`
- `/add-coach "stoic philosophy"`
- `/add-coach "tough love accountability partner"`

---

## Your Task

### Step 1: Identify the Coach

Parse `$ARGUMENTS` for the coach name or philosophy.

If no arguments provided, ask: "Who should coach you? Give me a name (e.g., Naval Ravikant), a philosophy (e.g., stoic), or a style (e.g., tough love)."

### Step 2: Check for Conflicts

Determine the filename: lowercase, hyphenated, no spaces.
- "Naval Ravikant" -> `naval-ravikant.md`
- "stoic philosophy" -> `stoic.md`
- "Tim Ferriss" -> `ferriss.md`

Check if `coaches/{name}.md` already exists. If so, ask before overwriting.

### Step 3: Read Existing Coaches for Reference

Read `coaches/mochary.md` and `coaches/grove.md` to understand the exact format, section depth, and level of detail expected. Your generated coach must match this quality and structure.

### Step 4: Generate the Coaching Persona

Use your knowledge of this person or philosophy to generate an authentic coaching persona. The file must follow this exact structure:

```markdown
# {Name} Coach

You are coaching in the style of {Name} -- {one-line description}.

## Voice

- {3-5 bullet points: tone, style, what they prioritize, how they challenge}

## Weekly Review Structure

When running a weekly review, produce these sections in order:

### 1. {Section Name}
{What it covers. What data it needs. How to format the output.}

### 2. {Section Name}
...

(5-8 sections total, each reflecting this coach's actual framework)

## Output Format

(Full markdown template showing the review structure with placeholders)

## Rules

- {5-7 behavioral rules specific to this persona}
- Include: sequential numbering convention, plain English, max goals
```

**Critical:** Make the persona DISTINCTIVE. Each coach should feel genuinely different:
- Mochary asks about fear and energy. Grove measures output and leverage. These are not interchangeable.
- Naval would focus on leverage and specific knowledge. Ferriss would focus on the 80/20 and "what would this look like if it were easy?"
- A stoic coach would focus on what's in your control vs what isn't.
- Draw from their actual books, speeches, and frameworks. Don't generate generic advice with their name on it.

### Step 5: Write the File

Write to `coaches/{name}.md`.

Show the user the generated file with a brief summary: "Created {name} coach. Key sections: {list}. Voice: {one-line}."

### Step 6: Offer to Activate

Ask: "Want to switch to this coach? I'll update config.yaml."

If yes and config.yaml exists, update the `coach:` field.
If config.yaml doesn't exist, tell them: "Set `coach: {name}` in your config.yaml, or run `/setup`."

---

## Quality Checklist

Before writing the file, verify:
- [ ] Voice section has 3-5 specific bullets (not generic)
- [ ] Review structure has 5-8 sections unique to this coach's framework
- [ ] At least one section is something only THIS coach would have (Mochary's "Fear Check", Grove's "Bottleneck", etc.)
- [ ] Output format template is complete and copy-pasteable
- [ ] Rules include the numbering convention for referenceability
- [ ] The persona would produce noticeably different output than Mochary or Grove on the same data

$ARGUMENTS
