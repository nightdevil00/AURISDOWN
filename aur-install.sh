#!/bin/bash
#
# A script to manually install a package from the AUR git repository.
# Usage: ./aur-install.sh <package-name>
#

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Pre-flight Checks ---

# Check if a package name was provided.
if [ -z "$1" ]; then
  echo "Error: No package name specified."
  echo "Usage: $0 <package-name>"
  exit 1
fi

PACKAGE_NAME="$1"
CLONE_URL="https://github.com/archlinux/aur.git"

# --- Main Logic ---

echo "==> Installing '$PACKAGE_NAME' from AUR git repository..."

# Create a temporary directory for the build
# mktemp creates a unique temporary directory to avoid conflicts
BUILD_DIR=$(mktemp -d -p "/tmp" "aur-build-$PACKAGE_NAME-XXXX")
echo "==> Using temporary build directory: $BUILD_DIR"

# Ensure cleanup happens when the script exits
trap 'echo "==> Cleaning up..."; rm -rf "$BUILD_DIR"' EXIT

cd "$BUILD_DIR"

# 1. Clone the repository
echo "==> Cloning repository for '$PACKAGE_NAME'..."
git clone --single-branch --branch "$PACKAGE_NAME" "$CLONE_URL" "$PACKAGE_NAME"

# 2. Change into the package directory
cd "$PACKAGE_NAME"

# 3. Build and install the package
echo "==> Building and installing '$PACKAGE_NAME'..."
# -s: syncs build dependencies
# -i: installs the package
# --noconfirm: prevents pacman from asking for confirmation
makepkg -si --noconfirm

echo "==> Successfully installed '$PACKAGE_NAME'."
