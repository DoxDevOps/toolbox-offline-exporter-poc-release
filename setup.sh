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

# Step 3: Install PM2
rm node_modules
tar -xvf node_modules.tar.gz
npm install --no-package-lock

rm toolbox-offline-exporter-poc-nodejs
tar -xvf toolbox-offline-exporter-poc-nodejs.tar.gz
cd toolbox-offline-exporter-poc-nodejs
npm install --no-package-lock

echo '##############################################################'
echo '#                   ToolBox Configuration                    #'
echo '#                                                            #'
echo '##############################################################'
node setup.js
cd ../

npx pm2 delete toolbox
npx pm2 start start index.js -f --name toolbox --cwd toolbox-offline-exporter-poc-nodejs

echo ''
echo 'ToolBox listens on port 6070'
echo 'using the server ip address'
echo 'for example, the  URL will be  http://127.0.0.1:6070'
echo 'replace 127.0.0.1 with the server ip address and open in the browser'