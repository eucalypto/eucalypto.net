#!/bin/bash
# setup-submodules.sh
# Initialize and checkout correct branches for all submodules

set -e  # Exit on error

echo "Initializing submodules..."
git submodule update --init --recursive

echo ""
echo "Checking out correct branches..."

# Checkout how-to-human.com branch for parsa-hugo theme
echo "Checking out 'eucalypto.net' branch for themes/parsa-hugo..."
cd themes/parsa-hugo
git fetch origin eucalypto.net
git checkout eucalypto.net
cd ../..

# Checkout main branch for public
echo "Checking out 'main' branch for public..."
cd public
git fetch origin main
git checkout main
cd ..

echo ""
echo "✓ All submodules initialized and branches checked out successfully!"
echo ""
git submodule status
