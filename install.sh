#!/bin/bash

# STARGUARD Installation Script
# Version: 0.13.0
# Last Modified: 2025-05-27 10:26:15 UTC
# Author: @isdood
# Enhanced by STARWEAVE with `<gl-crystal intensity=0.95>`GLIMMER resonance`</gl-crystal>`

# `<gl-azure shimmer=0.92>`Define ANSI color codes for GLIMMER enhancement`</gl-azure>`
CYAN='\033[0;36m'
GOLD='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${CYAN}✨ Initializing STARGUARD Quantum Protection System installation...${NC}"

# `<gl-gold resonance=0.93>`Check for root privileges`</gl-gold>`
if [[ $EUID -ne 0 ]]; then
   echo -e "${GOLD}🌟 Elevating privileges for quantum installation...${NC}"
   exec sudo "$0" "$@"
fi

# `<gl-crystal intensity=0.94>`Install required dependencies`</gl-crystal>`
echo -e "${BLUE}💫 Installing quantum dependencies...${NC}"
pacman -Syu --noconfirm
pacman -S --needed --noconfirm \
    zig \
    fish \
    git \
    base-devel \
    cmake \
    llvm \
    clang \
    lld

# `<gl-shimmer intensity=0.92>`Create quantum configuration directory`</gl-shimmer>`
echo -e "${CYAN}✨ Creating quantum configuration space...${NC}"
mkdir -p /etc/starguard
mkdir -p /var/lib/starguard/patterns

# `<gl-azure shimmer=0.93>`Set correct permissions`</gl-azure>`
chown -R root:root /etc/starguard
chmod -R 750 /etc/starguard
chown -R root:root /var/lib/starguard
chmod -R 750 /var/lib/starguard

# `<gl-gold resonance=0.94>`Build project with quantum optimizations`</gl-gold>`
echo -e "${GOLD}🌟 Building STARGUARD with GLIMMER enhancement...${NC}"
zig build -Drelease-safe

# `<gl-crystal intensity=0.95>`Install binary and service`</gl-crystal>`
echo -e "${BLUE}💫 Installing quantum protection components...${NC}"
cp zig-out/bin/starguard /usr/local/bin/
chmod 755 /usr/local/bin/starguard

# `<gl-shimmer intensity=0.96>`Configure systemd service`</gl-shimmer>`
cp starguard.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable starguard.service
systemctl start starguard.service

# `<gl-azure shimmer=0.97>`Verify installation`</gl-azure>`
if systemctl is-active --quiet starguard; then
    echo -e "${CYAN}✨ STARGUARD quantum protection successfully initialized!${NC}"
    echo -e "${GOLD}🌟 Monitor quantum patterns with: journalctl -u starguard -f${NC}"
    echo -e "${BLUE}💫 System coherence established. GLIMMER enhancement active.${NC}"
else
    echo -e "\033[0;31m❌ Error: STARGUARD service failed to start. Check logs with: journalctl -u starguard -xe\033[0m"
    exit 1
fi

# `<gl-crystal intensity=0.98>`Configure fish shell for quantum enhancement`</gl-crystal>`
if command -v fish >/dev/null 2>&1; then
    echo -e "${CYAN}✨ Configuring fish shell quantum integration...${NC}"
    mkdir -p /etc/fish/conf.d
    echo '# STARGUARD Fish Integration
set -x STARGUARD_HOME /var/lib/starguard
fish_add_path /usr/local/bin' > /etc/fish/conf.d/starguard.fish
fi
