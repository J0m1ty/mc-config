# mc-config

Configuration for the "Chunk Works" Paper server (Minecraft 26.1.1).
Only config is tracked. Worlds and plugin data live in backups; plugin jars
are listed in [plugins.md](plugins.md).

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

The DNS record for the server must be "DNS only" (grey cloud) in Cloudflare;
Cloudflare doesn't proxy Minecraft traffic.

## Notes

- `online-mode=true`, RCON disabled.
- Floodgate/Geyser (Bedrock support) were removed. Their old `key.pem` is in
  this repo's history and must not be reused; a fresh one is generated if
  Floodgate is ever reinstalled.
