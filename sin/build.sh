#!/bin/bash

# https://www.npmjs.com/package/phantomjs-prebuilt
# https://www.npmjs.com/package/casperjs
npm install phantomjs-prebuilt casperjs

pwd
ls
echo "bash the env"
bash ./casperjs_env.sh
echo "from build.sh"
echo $OPENSSL_CONF
echo $PATH
casperjs --version
phantomjs --version

echo "setting in buuild"

export OPENSSL_CONF=/etc/ssl
# Just need to remove the /sin from the path and this should work for anyone
export PATH="$PATH:/opt/render/project/src/sin/node_modules/phantomjs-prebuilt/lib/phantom/bin/"
export PATH="$PATH:/opt/render/project/src/sin/node_modules/casperjs/bin/"

casperjs --version
phantomjs --version

bundle install
