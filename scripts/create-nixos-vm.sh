#!/usr/bin/env bash
set -euo pipefail

# Configuration
VM_NAME="${VM_NAME:-NixOS-Dev}"
ISO_URL="${ISO_URL:-https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso}"
ISO_PATH="${ISO_PATH:-$HOME/VMs/nixos-minimal.iso}"
RAM_MB="${RAM_MB:-16384}"       # 16GB
CPUS="${CPUS:-8}"
DISK_MB="${DISK_MB:-200000}"    # 200GB
VRAM_MB="${VRAM_MB:-256}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NIX_CONFIG_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check prerequisites
if ! command -v prlctl &>/dev/null; then
    log_error "Parallels CLI (prlctl) not found. Please install Parallels Desktop."
    exit 1
fi

# Download ISO if not exists
mkdir -p "$(dirname "$ISO_PATH")"
if [[ ! -f "$ISO_PATH" ]]; then
    log_info "Downloading NixOS ISO to $ISO_PATH..."
    curl -L --progress-bar -o "$ISO_PATH" "$ISO_URL"
    log_info "Download complete."
else
    log_info "ISO already exists at $ISO_PATH"
fi

# Check if VM already exists
if prlctl list --all 2>/dev/null | grep -q "$VM_NAME"; then
    log_warn "VM '$VM_NAME' already exists."
    echo ""
    echo "Options:"
    echo "  1. Start existing VM:    prlctl start \"$VM_NAME\""
    echo "  2. Delete and recreate:  prlctl delete \"$VM_NAME\" && $0"
    echo "  3. Open Parallels:       open -a 'Parallels Desktop'"
    exit 0
fi

log_info "Creating VM: $VM_NAME"

# Create VM
prlctl create "$VM_NAME" --ostype linux

# Configure hardware
log_info "Configuring VM hardware (${RAM_MB}MB RAM, ${CPUS} CPUs, ${DISK_MB}MB disk)..."
prlctl set "$VM_NAME" --memsize "$RAM_MB"
prlctl set "$VM_NAME" --cpus "$CPUS"
prlctl set "$VM_NAME" --device-set hdd0 --size "$DISK_MB"

# Enable 3D acceleration for Wayland/Niri
log_info "Enabling 3D acceleration for Wayland..."
prlctl set "$VM_NAME" --3d-accelerate highest
prlctl set "$VM_NAME" --videosize "$VRAM_MB"

# Enable nested virtualization (useful for containers)
prlctl set "$VM_NAME" --nested-virt on 2>/dev/null || log_warn "Nested virtualization not available"

# Attach ISO
log_info "Attaching NixOS ISO..."
prlctl set "$VM_NAME" --device-set cdrom0 --image "$ISO_PATH"
prlctl set "$VM_NAME" --device-set cdrom0 --connect

# Setup shared folder for nix config
log_info "Setting up shared folder for nix configuration..."
prlctl set "$VM_NAME" --shf-host-add nix-config --path "$NIX_CONFIG_DIR"

# Enable clipboard sharing
prlctl set "$VM_NAME" --shared-clipboard on

# Enable time sync
prlctl set "$VM_NAME" --time-sync on

echo ""
log_info "VM '$VM_NAME' created successfully!"
echo ""
echo "Next steps:"
echo "  1. Start the VM:"
echo "     prlctl start \"$VM_NAME\""
echo ""
echo "  2. Boot from ISO and install NixOS:"
echo "     - Partition disk (e.g., /dev/sda1 for /boot, /dev/sda2 for /)"
echo "     - Mount partitions to /mnt"
echo "     - Run: nixos-generate-config --root /mnt"
echo "     - Edit hardware values into your nix config"
echo "     - Run: nixos-install --flake /mnt/media/psf/nix-config#p4x-parallels-nixos"
echo ""
echo "  3. After reboot, rebuild with:"
echo "     sudo nixos-rebuild switch --flake /media/psf/nix-config#p4x-parallels-nixos"
echo ""
echo "Shared folder will be mounted at: /media/psf/nix-config"
