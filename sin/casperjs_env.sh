#!/bin/bash

# https://github.com/ariya/phantomjs/issues/15449#issuecomment-694885196
export OPENSSL_CONF=/etc/ssl
# Just need to remove the /sin from the path and this should work for anyone
export PATH="$PATH:/opt/render/project/src/sin/node_modules/phantomjs-prebuilt/lib/phantom/bin/"
export PATH="$PATH:/opt/render/project/src/sin/node_modules/casperjs/bin/"
