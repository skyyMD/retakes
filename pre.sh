#!/bin/bash
set -e

CSGO_DIR="/home/steam/cs2-dedicated/game/csgo"
MODS_SRC="/mods"

echo "[PRE] Syncing mods..."

# Sicherstellen, dass Ziel existiert
mkdir -p "$CSGO_DIR"

# Mods kopieren / aktualisieren
rsync -av --delete \
  "$MODS_SRC/addons/" "$CSGO_DIR/addons/" || true

rsync -av --delete \
  "$MODS_SRC/cfg/" "$CSGO_DIR/cfg/" || true

rsync -av --delete \
  "$MODS_SRC/scripts/" "$CSGO_DIR/scripts/" || true

echo "[PRE] Mods synced."
