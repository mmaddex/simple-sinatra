#!/bin/bash
# https://www.npmjs.com/package/phantomjs-prebuilt
# https://www.npmjs.com/package/casperjs
#npm install phantomjs-prebuilt casperjs

#./casperjs_env.sh
#source ~/.bashrc
#casperjs --version
#phantomjs --version

echo "RENDER IS BUILDING FROM..."
echo $RENDER_INSTANCE_ID

echo $RENDER_PROJECT_CACHE_DIRS

echo lsing
ls
echo cronning
ls cron


echo "listing $XDG_CACHE_HOME"
ls $XDG_CACHE_HOME
echo "mkdir"
mkdir "$XDG_CACHE_HOME"
touch $XDG_CACHE_HOME/frombuild.txt


bundle install
touch ~/.irbrc_build && echo "IRB.conf[:USE_AUTOCOMPLETE] = false" >> ~/.irbrc_build
