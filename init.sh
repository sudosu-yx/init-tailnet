#!/bin/bash
set -euo pipefail

[ "$(id -u)" -ne 0 ] && { echo "❌ This script must be run as root."; exit 1; }

apt update && apt install -y qemu-system qemu-utils

[ ! -f ./.tailnet/boot.iso ] && mkdir -p ./.tailnet && cd ./.tailnet && \
    wget -c https://enterprise.proxmox.com/iso/proxmox-ve_9.1-1.iso -O boot.iso && cd - >/dev/null

# GPU setup (dynamic: pick first /dev/dri/card*)
if [ "${GPU:-N}" = "Y" ]; then
    mkdir -p /dev/dri

    GPU_DEV=$(ls /dev/dri/card* 2>/dev/null | head -n 1 || true)

    [ -n "$GPU_DEV" ] && \
        { [ ! -e /dev/dri/renderD128 ] && ln -sf "$GPU_DEV" /dev/dri/renderD128 && chmod 666 "$GPU_DEV" /dev/dri/renderD128; :; }
fi