#!/usr/bin/env bash
# migrate.sh
#
# Run this script INSIDE your PowerBI_Data_Analytics_Course codespace (or
# any machine where you have write access to that repo) to copy the
# Power_BI_Dashboard project folder into it.
#
# Usage:
#   chmod +x migrate.sh
#   ./migrate.sh
#
# After the script finishes, review the changes with `git diff --cached`,
# then commit and push:
#   git commit -m "Add Power_BI_Dashboard project"
#   git push

set -euo pipefail

COURSE_REPO="https://github.com/katkhess/PowerBI_Data_Analytics_Course.git"
DASHBOARD_REPO="https://github.com/katkhess/Power_BI_Dashboard.git"
TARGET_DIR="Power_BI_Dashboard"

# ── Determine where to put the files ────────────────────────────────────────
# If this script is being run from *inside* the course repo (e.g. the
# codespace), use the current working directory.  Otherwise clone the course
# repo next to a temporary clone of the dashboard repo.

if git -C . rev-parse --show-toplevel &>/dev/null; then
    TOPLEVEL=$(git -C . rev-parse --show-toplevel)
    REMOTE=$(git -C "$TOPLEVEL" remote get-url origin 2>/dev/null || true)
    if [[ "$REMOTE" == *"PowerBI_Data_Analytics_Course"* ]]; then
        COURSE_DIR="$TOPLEVEL"
        echo "✅  Detected PowerBI_Data_Analytics_Course repo at: $COURSE_DIR"
    else
        echo "⚠️  Current directory does not appear to be PowerBI_Data_Analytics_Course."
        echo "    Cloning it into /tmp/PowerBI_Data_Analytics_Course ..."
        COURSE_DIR="/tmp/PowerBI_Data_Analytics_Course"
        if [[ ! -d "$COURSE_DIR/.git" ]]; then
            git clone "$COURSE_REPO" "$COURSE_DIR"
        fi
    fi
else
    echo "Not inside a git repo. Cloning PowerBI_Data_Analytics_Course into /tmp ..."
    COURSE_DIR="/tmp/PowerBI_Data_Analytics_Course"
    if [[ ! -d "$COURSE_DIR/.git" ]]; then
        git clone "$COURSE_REPO" "$COURSE_DIR"
    fi
fi

# ── Clone the dashboard repo into a temp directory ───────────────────────────
DASH_TMP=$(mktemp -d)
trap 'rm -rf "$DASH_TMP"' EXIT

echo ""
echo "⬇️  Cloning Power_BI_Dashboard ..."
git clone --depth 1 "$DASHBOARD_REPO" "$DASH_TMP/Power_BI_Dashboard"

# ── Copy project folder ───────────────────────────────────────────────────────
DEST="$COURSE_DIR/$TARGET_DIR"

if [[ -d "$DEST" ]]; then
    echo ""
    read -r -p "⚠️  '$TARGET_DIR' already exists in the course repo. Overwrite? [y/N] " confirm
    case "$confirm" in
        [yY]*) rm -rf "$DEST" ;;
        *) echo "Aborted."; exit 1 ;;
    esac
fi

echo ""
echo "📁  Copying Power_BI_Dashboard/ into $DEST ..."
cp -r "$DASH_TMP/Power_BI_Dashboard/Power_BI_Dashboard" "$DEST"

# ── Stage the new files ───────────────────────────────────────────────────────
cd "$COURSE_DIR"
git add "$TARGET_DIR/"

echo ""
echo "✅  Done! Files staged. Review with:"
echo "    git diff --cached"
echo ""
echo "Then commit and push:"
echo "    git commit -m 'Add Power_BI_Dashboard project'"
echo "    git push"
