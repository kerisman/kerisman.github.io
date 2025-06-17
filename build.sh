#!/bin/bash
set -euo pipefail

REPO_DIR=$(pwd)
BUILD_DIR="$REPO_DIR/public"               # Zola build output
PUBLISH_DIR="$REPO_DIR/worktrees/gh-pages" # Worktree for gh-pages branch

# Build the site
zola build

# Prepare gh-pages worktree
if [ ! -d "$PUBLISH_DIR" ]; then
  echo "Adding gh-pages worktree..."
  git worktree add "$PUBLISH_DIR" gh-pages
fi

# Clean gh-pages content
rm -rf "$PUBLISH_DIR"/*

# Copy new site to gh-pages
cp -r "$BUILD_DIR"/* "$PUBLISH_DIR"

# Add .nojekyll to avoid GitHub Pages ignoring files/folders starting with _
touch "$PUBLISH_DIR/.nojekyll"

# Commit and push changes
cd "$PUBLISH_DIR"
git add --all
if git diff --quiet --cached; then
  echo "No changes to publish."
else
  git commit -m "Publish site: $(date -u +"%Y-%m-%d %H:%M UTC")"
  git push origin gh-pages
fi

echo "Publish complete."
