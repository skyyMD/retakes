#!/bin/bash
set -e

SEED_DIR="/home/steam/cs2-seed/csgo"
GAME_DIR="/home/steam/cs2-dedicated/game/csgo"

echo "[pre.sh] Starting mod seeding process..."

if [ ! -d "$SEED_DIR" ]; then
    echo "[pre.sh] Seed dir not found, skipping"
    exit 0
fi

echo "[pre.sh] Seeding addons..."
if [ -d "$SEED_DIR/addons" ]; then
    mkdir -p "$GAME_DIR/addons"
    cp -a "$SEED_DIR/addons/." "$GAME_DIR/addons/"
fi

echo "[pre.sh] Seeding cfg..."
if [ -d "$SEED_DIR/cfg" ]; then
    mkdir -p "$GAME_DIR/cfg"
    cp -a "$SEED_DIR/cfg/." "$GAME_DIR/cfg/"
fi

echo "[pre.sh] Seeding gameinfo.gi..."
if [ -f "$SEED_DIR/gameinfo.gi" ]; then
    cp -f "$SEED_DIR/gameinfo.gi" "$GAME_DIR/gameinfo.gi"
fi

echo "[pre.sh] Mod seeding finished"
exit 0
