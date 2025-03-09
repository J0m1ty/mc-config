#!/bin/bash
# filepath: /home/mc/server/start.sh

# Server directory
SERVER_DIR="/home/mc/server"

# Check if script is run as the mc user
if [ "$(whoami)" != "mc" ]; then
    echo "This script must be run as the mc user"
    exit 1
fi

# Make sure we're in the server directory
cd "$SERVER_DIR" || exit 1

# Function to check if the server is already running
check_running() {
    if pgrep -f "exec -a minecraft_process java" >/dev/null; then
        return 0  # Server is running
    else
        return 1  # Server is not running
    fi
}

# Only start the server if it's not already running
if check_running; then
    echo "Server is already running!"
    exit 0
fi

# Kill any orphaned screen sessions (optional)
screen -ls | grep minecraft | cut -d. -f1 | awk '{print $1}' | xargs -r kill

# Start the server in a screen session with optimized Java flags
echo "Starting Minecraft server at $(date)"
screen -dmS minecraft bash -c 'exec -a minecraft_process java -Xms8192M -Xmx8192M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC \
-XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC \
-XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 \
-XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 \
-XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 \
-XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs \
-Daikars.new.flags=true -jar server.jar nogui'

# Verify the server started successfully
sleep 5
if check_running; then
    echo "Server started successfully at $(date)"
    exit 0
else
    echo "Failed to start server at $(date)"
    exit 1
fi