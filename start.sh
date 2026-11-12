#!/usr/bin/env bash
# Start the server with Aikar's G1 flags (https://docs.papermc.io/paper/aikars-flags).
# MEMORY defaults to 6G; set MEMORY=8G etc. to override.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"
MEM=${MEMORY:-6G}
exec java -Xms"$MEM" -Xmx"$MEM" \
  -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem \
  -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 \
  -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 \
  -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 \
  -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 \
  -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true \
  -jar server.jar --nogui
