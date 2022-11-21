#!/bin/bash

# https://www.npmjs.com/package/phantomjs-prebuilt
# https://www.npmjs.com/package/casperjs
npm install phantomjs-prebuilt casperjs


./casperjs_env.sh
echo "from build.sh"
source ~/.bashrc
casperjs --version
phantomjs --version

bundle install
