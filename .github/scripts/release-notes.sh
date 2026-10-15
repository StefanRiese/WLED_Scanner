#!/bin/sh
# Prints the release note for a tag: its CHANGELOG.md section, the shared footer
# and a link comparing it with the previous tag. Fails if the section is missing.
# Usage: .github/scripts/release-notes.sh v1.2.0
set -eu
TAG="$1"
cd "$(dirname "$0")/../.."

SECTION=$(awk -v tag="$TAG" '
    /^## / { found = (index($0, "## " tag " ") == 1 || $0 == "## " tag); next }
    found
' CHANGELOG.md | sed -e '/./,$!d')   # drop leading blank lines

if [ -z "$(printf '%s' "$SECTION" | tr -d '[:space:]')" ]; then
    echo "error: CHANGELOG.md has no '## $TAG' section" >&2
    exit 1
fi

printf '%s\n\n' "$SECTION"
cat .github/release-notes-footer.md

PREVIOUS=$(git describe --tags --abbrev=0 "$TAG^" 2>/dev/null || true)
if [ -n "$PREVIOUS" ]; then
    REPO="${GITHUB_REPOSITORY:-StefanRiese/WLED_Scanner}"
    printf '\n**Full changelog:** https://github.com/%s/compare/%s...%s\n' "$REPO" "$PREVIOUS" "$TAG"
fi
