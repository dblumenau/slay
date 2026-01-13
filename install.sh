#!/usr/bin/env bash
set -e

# slay installer
# Usage: curl -fsSL https://raw.githubusercontent.com/dblumenau/slay/main/install.sh | bash

REPO="dblumenau/slay"
BRANCH="main"
INSTALL_DIR="${SLAY_INSTALL_DIR:-$HOME/.local/bin}"

echo "✨ Installing slay..."

# Create install directory
mkdir -p "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/slay-lib"
mkdir -p "$INSTALL_DIR/slay-lib/examples"

# Download main script
curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/slay" -o "$INSTALL_DIR/slay"
chmod +x "$INSTALL_DIR/slay"

# Download library modules
for module in colors.sh check-deps.sh messages.sh project-cache.sh git-sync.sh actions.sh interactive.sh watch-loop.sh; do
    curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/slay-lib/$module" -o "$INSTALL_DIR/slay-lib/$module"
done

# Download example discovery scripts
for example in discover-deployment-yaml.sh discover-docker-compose.sh discover-env-file.sh README.md; do
    curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/slay-lib/examples/$example" -o "$INSTALL_DIR/slay-lib/examples/$example"
done
chmod +x "$INSTALL_DIR/slay-lib/examples"/*.sh 2>/dev/null || true

echo ""
echo "✅ slay installed to $INSTALL_DIR/slay"
echo ""

# Check if install dir is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "⚠️  $INSTALL_DIR is not in your PATH"
    echo ""
    echo "Add this to your ~/.zshrc or ~/.bashrc:"
    echo "  export PATH=\"\$PATH:$INSTALL_DIR\""
    echo ""
fi

# Check dependencies
echo "Checking dependencies..."
missing=""
command -v gum &> /dev/null || missing="$missing gum"
command -v fd &> /dev/null || missing="$missing fd"
command -v curl &> /dev/null || missing="$missing curl"

if [ -n "$missing" ]; then
    echo ""
    echo "⚠️  Missing dependencies:$missing"
    echo ""
    echo "Install with: brew install$missing"
else
    echo "✅ All dependencies installed"
fi

echo ""
echo "Run 'slay' to get started, or 'slay -h' for help"
echo ""
echo "💅 She's ready to slay."
