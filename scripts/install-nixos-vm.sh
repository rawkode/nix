#!/usr/bin/env bash
# Run this script from inside the NixOS live ISO after booting the VM
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_step() { echo -e "${BLUE}[STEP]${NC} $1"; }

# Configuration
FLAKE_CONFIG="p4x-parallels-nixos"
DISK_DEVICE="/dev/sda"

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║           NixOS Parallels VM Automated Installer               ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    log_error "This script must be run as root (use sudo)"
    exit 1
fi

# Check if disk exists
if [[ ! -b "$DISK_DEVICE" ]]; then
    log_error "Disk device $DISK_DEVICE not found"
    log_info "Available disks:"
    lsblk -d -o NAME,SIZE,TYPE
    exit 1
fi

# Find the shared folder mount point
SHARED_FOLDER=""
for path in /media/psf/nix-config /mnt/nix-config /run/media/*/nix-config; do
    if [[ -d "$path" ]] && [[ -f "$path/flake.nix" ]]; then
        SHARED_FOLDER="$path"
        break
    fi
done

if [[ -z "$SHARED_FOLDER" ]]; then
    log_warn "Shared folder not found. Attempting to mount Parallels shared folders..."

    # Try to load prl_fs module and mount
    modprobe prl_fs 2>/dev/null || true
    mkdir -p /mnt/nix-config

    # Try mounting the shared folder
    if mount -t prl_fs nix-config /mnt/nix-config 2>/dev/null; then
        SHARED_FOLDER="/mnt/nix-config"
        log_info "Mounted shared folder at $SHARED_FOLDER"
    else
        log_error "Could not mount shared folder."
        log_info "Please ensure the VM has a shared folder named 'nix-config'"
        log_info "pointing to your nix configuration directory."
        echo ""
        log_info "Alternatively, you can clone the repo:"
        log_info "  nix-shell -p git --run 'git clone https://github.com/rawkode/nix /tmp/nix'"
        log_info "Then re-run this script with: FLAKE_PATH=/tmp/nix $0"
        exit 1
    fi
fi

# Allow override via environment variable
FLAKE_PATH="${FLAKE_PATH:-$SHARED_FOLDER}"

log_info "Using flake at: $FLAKE_PATH"
log_info "Target disk: $DISK_DEVICE"
log_info "Configuration: $FLAKE_CONFIG"
echo ""

# Confirmation
log_warn "This will ERASE ALL DATA on $DISK_DEVICE!"
echo ""
read -p "Are you sure you want to continue? (type 'yes' to confirm): " confirm
if [[ "$confirm" != "yes" ]]; then
    log_info "Aborted."
    exit 0
fi

echo ""
log_step "Step 1/4: Running disko to partition and format disk..."
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
    --mode disko \
    --flake "$FLAKE_PATH#$FLAKE_CONFIG"

log_step "Step 2/4: Verifying mount points..."
if ! mountpoint -q /mnt; then
    log_error "Root filesystem not mounted at /mnt"
    exit 1
fi
log_info "Disk partitioned and mounted successfully"
lsblk "$DISK_DEVICE"

log_step "Step 3/4: Installing NixOS..."
nixos-install --flake "$FLAKE_PATH#$FLAKE_CONFIG" --no-root-passwd

log_step "Step 4/4: Setting up user password..."
log_info "Please set a password for the 'rawkode' user:"
nixos-enter --root /mnt -c 'passwd rawkode' || {
    log_warn "Failed to set password interactively."
    log_info "You can set it after first boot with: passwd rawkode"
}

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    Installation Complete!                       ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
log_info "You can now reboot into your new NixOS system:"
echo "  1. Shut down: shutdown now"
echo "  2. Eject the ISO in Parallels"
echo "  3. Start the VM"
echo ""
log_info "After first boot, rebuild with:"
echo "  sudo nixos-rebuild switch --flake /media/psf/nix-config#$FLAKE_CONFIG"
echo ""
