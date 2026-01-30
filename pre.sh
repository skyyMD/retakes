#!/bin/bash
set -e

SEED="/home/steam/cs2-seed/csgo"
GAME="/home/steam/cs2-dedicated/game/csgo"

echo "[pre.sh] Starting mod seeding..."

mkdir -p "$GAME"

# addons
if [ -d "$SEED/addons" ]; then
  echo "[pre.sh] Copying addons..."
  cp -a "$SEED/addons" "$GAME/"
fi

# cfg
if [ -d "$SEED/cfg" ]; then
  echo "[pre.sh] Copying cfg..."
  cp -a "$SEED/cfg" "$GAME/"
fi

# gameinfo.gi
if [ -f "$SEED/gameinfo.gi" ]; then
  echo "[pre.sh] Copying gameinfo.gi..."
  cp -f "$SEED/gameinfo.gi" "$GAME/gameinfo.gi"
fi

# CRLF fix
echo "[pre.sh] Normalizing line endings..."
find "$GAME" -type f \
  \( -name "*.cfg" -o -name "*.txt" -o -name "*.ini" -o -name "*.vdf" -o -name "*.json" \) \
  -exec sed -i 's/\r$//' {} \; || true

echo "[pre.sh] Mod seeding done."
