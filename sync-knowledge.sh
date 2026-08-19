#!/bin/bash
# Sync shared knowledge (used by scientific-assistant and swe-hpc-assistant)

KB_DIR="$HOME/.config/goose/shared-knowledge"

cd "$KB_DIR"

echo "Shared Knowledge Sync"
echo "===================================="

# Check if git repo exists
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial shared knowledge base"
    echo ""
    echo "Next steps:"
    echo "1. Create a GitHub/GitLab repository for shared knowledge"
    echo "2. Run: git remote add origin <your-repo-url>"
    echo "3. Run: git push -u origin main"
    exit 0
fi

# Commit any local changes
if [[ -n $(git status -s) ]]; then
    echo "Local changes detected, committing..."
    git add .
    git commit -m "Update shared knowledge base - $(date '+%Y-%m-%d %H:%M')"
fi

# Pull remote changes (only if a remote is configured)
if git remote get-url origin >/dev/null 2>&1; then
    echo "Pulling remote changes..."
    git pull --rebase

    echo "Pushing local changes..."
    git push origin main

    echo ""
    echo "✓ Sync complete!"
    echo "Shared knowledge is up to date on: $(git remote get-url origin)"
else
    echo ""
    echo "No remote configured yet - local commit only."
    echo "Run: git remote add origin <your-repo-url> && git push -u origin main"
fi
