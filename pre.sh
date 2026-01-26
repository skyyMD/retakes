#!/bin/bash
# Pre-hook script that runs before CS2 server starts
# This seeds your mods from the mounted seed directory into the game directory

SEED_DIR="/home/steam/cs2-seed/csgo"
GAME_DIR="/home/steam/cs2-dedicated/game/csgo"

echo "[pre.sh] Starting mod seeding process..."

# Check if seed directory exists and has content
if [ -d "$SEED_DIR" ]; then
    echo "[pre.sh] Found seed directory at $SEED_DIR"
    
    # Copy addons folder if it exists
    if [ -d "$SEED_DIR/addons" ]; then
        echo "[pre.sh] Copying addons from seed..."
        mkdir -p "$GAME_DIR/addons"
        cp -r "$SEED_DIR/addons/"* "$GAME_DIR/addons/" 2>/dev/null || true
        echo "[pre.sh] Addons seeded successfully"
        
        # Convert Windows line endings to Unix for config files
        echo "[pre.sh] Converting line endings for config files..."
        find "$GAME_DIR/addons" -type f \( -name "*.vdf" -o -name "*.ini" -o -name "*.cfg" -o -name "*.txt" -o -name "*.json" -o -name "*.yaml" \) -exec sed -i 's/\r$//' {} \; 2>/dev/null || true
        echo "[pre.sh] Line endings converted"
    fi
    
    # Copy cfg folder if it exists
    if [ -d "$SEED_DIR/cfg" ]; then
        echo "[pre.sh] Copying cfg from seed..."
        mkdir -p "$GAME_DIR/cfg"
        cp -r "$SEED_DIR/cfg/"* "$GAME_DIR/cfg/" 2>/dev/null || true
        # Convert line endings
        find "$GAME_DIR/cfg" -type f \( -name "*.cfg" -o -name "*.txt" \) -exec sed -i 's/\r$//' {} \; 2>/dev/null || true
        echo "[pre.sh] Configs seeded successfully"
    fi
    
    # Copy gameinfo.gi if it exists (Metamod patch)
    if [ -f "$SEED_DIR/gameinfo.gi" ]; then
        echo "[pre.sh] Copying patched gameinfo.gi from seed..."
        cp -f "$SEED_DIR/gameinfo.gi" "$GAME_DIR/gameinfo.gi"
        # Convert line endings
        sed -i 's/\r$//' "$GAME_DIR/gameinfo.gi" 2>/dev/null || true
        echo "[pre.sh] gameinfo.gi patched successfully"
    fi
    
    echo "[pre.sh] Mod seeding complete!"
else
    echo "[pre.sh] No seed directory found at $SEED_DIR - skipping seeding"
fi
