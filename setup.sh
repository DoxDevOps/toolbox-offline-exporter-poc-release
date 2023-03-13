# Step 1: Extract Node.js and npm binaries to /usr/local
tar -xvf node-v14.18.0-linux-x64.tar.xz
sudo mv node-v14.18.0-linux-x64 /usr/local/
sudo chown -R root:root /usr/local/node-v14.18.0-linux-x64
sudo ln -s /usr/local/node-v14.18.0-linux-x64/bin/node /usr/bin/node
sudo ln -s /usr/local/node-v14.18.0-linux-x64/bin/npm /usr/bin/npm
sudo ln -s /usr/local/node-v14.18.0-linux-x64/bin/npx /usr/bin/npx


# Step 2: Install npm from the downloaded npm tarball
mkdir -p ~/.npm-global
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
npm config set prefix '~/.npm-global'

# Step 3: Install PM2
tar -xvf node_modules.tar.gz
npm install --no-package-lock

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
npx pm2 start index.js -f --name toolbox --cwd toolbox-offline-exporter-poc-nodejs

# Step 4: Check if the script is already in crontab
if crontab -l | grep -q '_init_.sh'; then
  echo ''
else
  # Step 5: Add the script to crontab
  (crontab -l 2>/dev/null; echo "@reboot /var/www/toolbox-offline-exporter-poc-release/_init_.sh") | crontab -
  echo ''
fi

echo ''
echo 'ToolBox listens on port 6070'
echo 'using the server ip address'
echo 'for example, the  URL will be  http://127.0.0.1:6070'
echo 'replace 127.0.0.1 with the server ip address and open in the browser'