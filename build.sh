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

echo $RENDER_PROJECT_CACHE_DIRS

echo lsing
ls

bundle install
touch ~/.irbrc_build && echo "IRB.conf[:USE_AUTOCOMPLETE] = false" >> ~/.irbrc_build
