#!/bin/sh
set -eu

### CONFIG ###########################################################

GRUB_BTRFS_TAG="v4.14"
GRUB_BTRFS_REPO="https://github.com/Antynea/grub-btrfs.git"
WORKDIR="/tmp/grub-btrfs"

PACKAGES_FILE="$(dirname "$0")/packages.list"

### HELPERS ##########################################################

log() {
    printf "\n==> %s\n" "$1"
}

require_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Run as root (sudo)" >&2
        exit 1
    fi
}

### START ############################################################

require_root

log "Updating apt cache"
apt update

### PACKAGES #########################################################

log "Installing base packages"
grep -Ev '^\s*#|^\s*$' "$PACKAGES_FILE" | xargs apt install -y


### SNAPSHOT #########################################################

log "Initializing snapper (root config)"

if ! snapper -c root list >/dev/null 2>&1; then
    snapper -c root create-config /
fi

systemctl enable --now snapper-cleanup.timer
systemctl enable --now snapper-timeline.timer

### GRUB-BTRFS #######################################################

log "Installing grub-btrfs from tag ${GRUB_BTRFS_TAG}"

rm -rf "$WORKDIR"
git clone --branch "$GRUB_BTRFS_TAG" --depth 1 "$GRUB_BTRFS_REPO" "$WORKDIR"

cd "$WORKDIR"
make install

systemctl enable --now grub-btrfsd.service

### FLATPAK ##########################################################

log "Configuring Flathub (user scope)"

if ! sudo -u "${SUDO_USER:-$USER}" flatpak remote-list | grep -q flathub; then
    sudo -u "${SUDO_USER:-$USER}" \
        flatpak remote-add --if-not-exists --user flathub \
        https://flathub.org/repo/flathub.flatpakrepo
fi

### DONE #############################################################

log "Setup completed successfully"
echo "Reboot recommended."
