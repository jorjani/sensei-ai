# Sensei AI -- Demo Runbook

Pre-demo setup and step-by-step script. Just say "next" to advance.

---

## PRE-DEMO (do before presenting)

```bash
git clone https://github.com/jorjani/sensei-ai.git ~/demo-sensei
cd ~/demo-sensei
./scripts/demo-setup.sh
cp examples/config.demo.yaml config.yaml
```

Verify it worked:
```bash
tree -I '.git' --dirsfirst -L 2
```

Open these files in tabs so you can show them quickly:
- `coaches/mochary.md`
- `coaches/grove.md`
- `examples/demo-workspace/priorities.md`
- `examples/demo-workspace/TODO.md`
- `examples/sample-review.md` (fallback)

---

## STEP 1: Hook

SAY:
> "Every founder says they want a coach. Someone who looks at what you actually did -- not what you planned -- and asks the hard questions. What if you could build that with just markdown files and Claude Code?"

---

## STEP 2: Show repo structure

RUN:
```bash
tree -I '.git' --dirsfirst -L 2
```

SAY:
> "No code. The entire coaching system is prompt fragments. Coaches are markdown. Data sources are markdown. Claude Code is the runtime."

---

## STEP 3: Show the Mochary coach

SHOW: `coaches/mochary.md` (scroll to Voice + first 2 sections)

SAY:
> "This is Matt Mochary's CEO coaching framework. Energy audit, the one thing, fear check, commitment. The file defines both how the coach talks and what it produces."

---

## STEP 4: Show extensibility

SHOW: `coaches/grove.md` (just the Voice section)

SAY:
> "Want Andy Grove instead? Drop a markdown file. Same data, different lens. Grove cares about output and leverage. Mochary cares about energy and fear."

---

## STEP 5: Show the demo data

SHOW: `examples/demo-workspace/priorities.md`

SAY:
> "Here's our founder. Priority #1: find product-market fit -- talk to 20 customers. Priority #2: get to $10k MRR. Let's see what actually happened."

RUN:
```bash
git -C examples/demo-workspace/internal-tools log --oneline
git -C examples/demo-workspace/product log --oneline
```

SAY:
> "8 commits on internal dashboards and analytics. 2 commits on the product, both bug fixes. Zero customer calls. Sound familiar?"

---

## STEP 6: Run the review live

RUN:
```bash
claude
```

Then type:
```
/review
```

WHILE IT RUNS, SAY:
> "It's reading git history across all three repos, reading the TODO, reading the priorities. Now it's applying Mochary's coaching framework to what it found."

WHEN OUTPUT APPEARS, let the audience read the Energy Audit and Fear Check. Point to:
- "You're building infrastructure to measure customers instead of talking to them"
- "The health score Slack bot is a proxy for the conversations you're avoiding"

---

## STEP 7: The commitment question

POINT TO the Commitment section at the bottom.

SAY:
> "It doesn't solve the problem. It names the pattern and asks for a commitment. What, by when, how will you know. That's what a real coach does."

---

## STEP 8: Generate a new coach live

TYPE (in the same Claude session):
```
/add-coach Naval Ravikant
```

WAIT for it to generate. Show the output.

SAY:
> "Full persona from one command. Leverage, specific knowledge, long-term games. All from Claude's training data. Works with any name or philosophy."

---

## STEP 9: Automation

SAY:
> "This runs on a schedule. Saturday morning, you wake up to a coaching check-in in your terminal. Launchd on Mac, cron on Linux."

---

## STEP 10: Close

SAY:
> "Clone it. Pick your coach. Point it at your repos. The whole system is markdown files."

SHOW THE URL:
> github.com/jorjani/sensei-ai

---

## IF LIVE DEMO IS SLOW

Open `examples/sample-review.md` and walk through it instead. Same story, same coaching output, no waiting.

## IF SOMEONE ASKS "CAN IT DO X?"

> "Write a markdown file. New coach? Markdown. New data source? Markdown. Different review cadence? Change the command."
