# mc-config

Configuration for the "Chunk Works" Paper server (Minecraft 26.1.1).
Only config is tracked here. Worlds and plugin data live in backups, and necessary plugin jars are listed in [plugins.md](plugins.md).

## Restore

```bash
git clone git@github.com:J0m1ty/mc-config.git server && cd server
# 1. Paper jar for 26.1.1 from https://papermc.io/downloads -> server.jar
# 2. Plugin jars from plugins.md -> plugins/
# 3. World + plugin data from the latest backup:
tar -xzf /path/to/mc-backup-YYYY-MM-DD.tar.gz --skip-old-files
# 4. Run
./start.sh                       # or: pm2 start ecosystem.config.cjs
```

Java: Paper 26.x needs Java 25 (e.g. Amazon Corretto 25).

## Ports

| Port | Protocol | Use |
|---|---|---|
| 25565 | TCP | Minecraft |
| 24454 | UDP | Simple Voice Chat |

