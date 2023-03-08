cd node_modules/toolbox-offline-exporter-poc-nodejs
echo '##############################################################'
echo '#                   ToolBox Configuration                    #'
echo '#                                                            #'
echo '##############################################################'
node setup.js
pm2 start index.js -f --name toolbox


echo '######################################################################'
echo ''
echo 'ToolBox listens on port 6070'
echo 'using the server ip address'
echo 'for example, the  URL will be  http:127.0.0.1//:6070'
echo 'replace 127.0.0.1 with the server ip address and visit/open the URL in the browser'