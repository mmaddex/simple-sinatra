#!/bin/bash

# https://www.npmjs.com/package/phantomjs-prebuilt
# https://www.npmjs.com/package/casperjs
npm install phantomjs-prebuilt casperjs

pwd
ls
echo "bash the env"
bash ./casperjs_env.sh
echo "from build.sh"
source ~/.bashrc
echo $OPENSSL_CONF
echo $PATH
casperjs --version
phantomjs --version

bundle install
