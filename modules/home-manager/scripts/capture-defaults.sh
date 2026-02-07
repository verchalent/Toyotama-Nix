#!/usr/bin/env bash
# capture-defaults.sh — Dump an app's defaults and generate a nix skeleton
#
# Usage: ./capture-defaults.sh <bundle-id>
# Example: ./capture-defaults.sh com.raycast.macos
#
# Outputs a curated .nix skeleton using system.defaults.CustomUserPreferences
# and flags values that look like secrets.

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <bundle-id>" >&2
  echo "Example: $0 com.raycast.macos" >&2
  exit 1
fi

BUNDLE_ID="$1"
OUTPUT_FILE="${BUNDLE_ID}.defaults.txt"

echo "Reading defaults for ${BUNDLE_ID}..."
defaults read "${BUNDLE_ID}" > "${OUTPUT_FILE}" 2>/dev/null || {
  echo "Error: No defaults found for ${BUNDLE_ID}" >&2
  exit 1
}

echo "Defaults saved to ${OUTPUT_FILE}"
echo ""
echo "=== Potential secrets (review before committing) ==="
grep -iE '(license|key|token|secret|password|credential|apikey)' "${OUTPUT_FILE}" || echo "  (none found)"

echo ""
echo "=== Nix skeleton ==="
cat <<EOF
{ ... }: {
  system.defaults.CustomUserPreferences."${BUNDLE_ID}" = {
    # TODO: Curate settings from ${OUTPUT_FILE}
    # Drop: onboarding flags, internal state, timestamps, binary blobs
    # Keep: appearance, behavior, hotkeys, functional settings
  };
}
EOF
