#!/usr/bin/env bash
# Copy AGENTS.md to a user-specified path (or current directory).
# Warns before overwriting; skips if user answers n.

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${SCRIPT_DIR}/AGENTS.md"
DEFAULT_DEST="."

if [[ ! -f "$SOURCE" ]]; then
  echo "Error: AGENTS.md not found at $SOURCE" >&2
  exit 1
fi

read -r -p "Destination path [${DEFAULT_DEST}]: " raw_dest
DEST="${raw_dest:-$DEFAULT_DEST}"
DEST="$(eval echo "$DEST")"
DEST_FILE="${DEST%/}/AGENTS.md"

if [[ -f "$DEST_FILE" ]]; then
  read -r -p "Overwrite $DEST_FILE? [y/N]: " confirm
  case "$confirm" in
    [yY]|[yY][eE][sS]) ;;
    *) echo "Skipped."; exit 0 ;;
  esac
fi

mkdir -p "$DEST"
cp "$SOURCE" "$DEST_FILE"
echo "Copied AGENTS.md to $DEST_FILE"
