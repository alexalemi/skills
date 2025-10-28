#!/bin/bash
set -e

JANET_VERSION="1.39.1"
INSTALL_DIR="${HOME}/.local"

echo "Installing Janet ${JANET_VERSION}..."

# Check if Janet is already installed
if command -v janet &> /dev/null; then
    CURRENT_VERSION=$(janet -v 2>&1 | head -n1 | grep -oP '\d+\.\d+\.\d+' || echo "unknown")
    echo "Janet ${CURRENT_VERSION} is already installed."
    read -p "Do you want to reinstall? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

# Create temp directory
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

# Download Janet
echo "Downloading Janet ${JANET_VERSION}..."
wget -q "https://github.com/janet-lang/janet/releases/download/v${JANET_VERSION}/janet-v${JANET_VERSION}-linux-x64.tar.gz"

# Extract
echo "Extracting..."
tar -xzf "janet-v${JANET_VERSION}-linux-x64.tar.gz"

# Install
echo "Installing to ${INSTALL_DIR}..."
cd "janet-v${JANET_VERSION}-linux"

# Copy files
mkdir -p "${INSTALL_DIR}/bin"
mkdir -p "${INSTALL_DIR}/lib"
mkdir -p "${INSTALL_DIR}/include/janet"

cp bin/janet "${INSTALL_DIR}/bin/"
cp -r lib/* "${INSTALL_DIR}/lib/" 2>/dev/null || true
cp -r include/janet/* "${INSTALL_DIR}/include/janet/" 2>/dev/null || true

# Cleanup
cd ~
rm -rf "$TMP_DIR"

# Check if PATH includes .local/bin
if [[ ":$PATH:" != *":${HOME}/.local/bin:"* ]]; then
    echo ""
    echo "⚠️  ${HOME}/.local/bin is not in your PATH"
    echo "Add this line to your ~/.bashrc or ~/.zshrc:"
    echo ""
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

echo "✓ Janet ${JANET_VERSION} installed successfully!"
echo ""
echo "Verify installation with: janet -v"
