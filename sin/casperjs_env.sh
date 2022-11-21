#!/bin/bash

echo "configuring casperjs environment"
# https://github.com/ariya/phantomjs/issues/15449#issuecomment-694885196
echo "export OPENSSL_CONF=/etc/ssl" >> ~/.bashrc
# Just need to remove the /sin from the path and this should work for anyone
echo 'export PATH="$PATH:/opt/render/project/src/sin/node_modules/phantomjs-prebuilt/lib/phantom/bin/"' >> ~/.bashrc
echo 'export PATH="$PATH:/opt/render/project/src/sin/node_modules/casperjs/bin/"' >> ~/.bashrc

echo "from casperjs_env.sh"
echo $OPENSSL_CONF
echo $PATH
casperjs --version
phantomjs --version
