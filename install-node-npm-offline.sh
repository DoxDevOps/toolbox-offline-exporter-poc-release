# Step 1: Extract Node.js and npm binaries to /usr/local
tar -xvf node-v14.18.0-linux-x64.tar.xz
sudo mv node-v14.18.0-linux-x64 /usr/local/
sudo chown -R root:root /usr/local/node-v14.18.0-linux-x64
sudo ln -s /usr/local/node-v14.18.0-linux-x64/bin/node /usr/bin/node
sudo ln -s /usr/local/node-v14.18.0-linux-x64/bin/npm /usr/bin/npm

# Step 2: Install npm from the downloaded npm tarball
mkdir -p ~/.npm-global
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
npm config set prefix '~/.npm-global'

# Step 2: Install PM2
npm install pm2-5.2.2.tgz -g --verbose --no-progress
npm install toolbox-offline-exporter-poc-nodejs-1.0.0.tgz --verbose --no-progress
cd node_modules/toolbox-offline-exporter-poc-nodejs
npm install --verbose --no-progress
node setup.js
pm2 start index.js --name toolbox