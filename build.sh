#!/bin/bash
# https://www.npmjs.com/package/phantomjs-prebuilt
# https://www.npmjs.com/package/casperjs
#npm install phantomjs-prebuilt casperjs

#./casperjs_env.sh
#source ~/.bashrc
#casperjs --version
#phantomjs --version

#echo testing > file.txt
#echo catfile
#cat file.txt

#echo testingopenssl
#echo '#testing' >> /usr/lib/ssl/openssl.cnf
#echo '#testing' >> /etc/ssl/openssl.cnf
mkdir /opt/render/project/testfil
touch /opt/render/project/testfil/file.txt
mkdir /opt/render/project/src/insrc
touch /opt/render/project/src/insrc/file.txt

echo $RENDER_PROJECT_CACHE_DIRS

echo lsing
ls
echo cronning
ls cron

bundle install
touch ~/.irbrc_build && echo "IRB.conf[:USE_AUTOCOMPLETE] = false" >> ~/.irbrc_build
