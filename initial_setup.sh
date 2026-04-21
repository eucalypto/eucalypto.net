#!/bin/bash
# setup.sh
# Initializes the repo and attaches the theme submodule to the correct branch to prevent detached HEAD states.

set -e  # Exit immediately if a command fails

echo "🚀 Initializing submodules..."
git submodule update --init --recursive

echo ""
echo "🌿 Attaching theme to 'eucalypto.net' branch..."
cd themes/parsa-hugo
# Fetch ensures the local git knows about the branch if it's a fresh clone
git fetch origin eucalypto.net
git checkout eucalypto.net
cd ../..

echo ""
echo "✅ Setup complete! Theme is ready for local edits."
echo ""