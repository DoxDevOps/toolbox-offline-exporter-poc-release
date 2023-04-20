cd /var/www/toolbox-offline-exporter-poc-release
npx pm2 delete toolbox
npx pm2 start index.js -f --name toolbox --cwd toolbox-offline-exporter-poc-nodejs --interpreter /usr/local/node-v14.18.0-linux-x64/bin/node