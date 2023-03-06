# Step 1: Extract Node.js and npm binaries to /usr/local
tar -xvf node-v14.18.0-linux-x64.tar.xz
sudo mv node-v14.18.0-linux-x64 /usr/local/
sudo chown -R root:root /usr/local/node-v14.18.0-linux-x64
sudo ln -s /usr/local/node-v14.18.0-linux-x64/bin/node /usr/bin/node
sudo ln -s /usr/local/node-v14.18.0-linux-x64/bin/npm /usr/bin/npm

# Step 2: Install npm from the downloaded npm tarball
mkdir -p ~/.npm-global
tar -xvf npm-8.1.0.tgz -C ~/.npm-global --strip-components=1
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
npm config set prefix '~/.npm-global'