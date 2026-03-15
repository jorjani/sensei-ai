#!/bin/bash
# Automated AI Coach Review
# Runs claude with the /review command and saves output.
#
# Usage:
#   ./run-review.sh           # Run and save to results/
#   ./run-review.sh --notify  # Run, save, and send macOS notification

set -euo pipefail

# Allow running from within a Claude Code session
unset CLAUDECODE 2>/dev/null || true

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
RESULTS_DIR="$REPO_ROOT/results"
DATE=$(date +%Y-%m-%d)
OUTFILE="$RESULTS_DIR/$DATE-review.md"

# Skip if already ran today
if [ -f "$OUTFILE" ]; then
  echo "Already ran today: $OUTFILE"
  exit 0
fi

# Check for config
if [ ! -f "$REPO_ROOT/config.yaml" ]; then
  echo "Error: No config.yaml found. Run /setup in Claude Code first."
  exit 1
fi

mkdir -p "$RESULTS_DIR"

echo "Running weekly review..."
cd "$REPO_ROOT"

claude -p "Run /review and output the full review." --max-turns 25 > "$OUTFILE" 2>/dev/null

echo "Saved to: $OUTFILE"

# Optional macOS notification
if [[ "${1:-}" == "--notify" ]] && command -v osascript &>/dev/null; then
  osascript -e "display notification \"Weekly review ready\" with title \"AI Coach\" subtitle \"$(basename "$OUTFILE")\""
fi
