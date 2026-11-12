// PM2: pm2 start ecosystem.config.cjs  (run as root; the server runs as the "mc" user)
module.exports = {
  apps: [{
    name: 'minecraft',
    cwd: __dirname,
    script: './start.sh',
    interpreter: '/bin/bash',
    uid: 'mc',
    gid: 'mc',
    kill_timeout: 30000,          // give the server time to save on stop
    exp_backoff_restart_delay: 1000,
    autorestart: true,
  }],
};
