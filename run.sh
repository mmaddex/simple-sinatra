#!/bin/bash

#./casperjs_env.sh
#source ~/.bashrc

echo "starting on all the ports"
echo $SSH_VAR
echo $RAILS_ENV
echo 'testmd'
cat test.md

#echo "checking phantomjs"
#phantomjs --version

#echo "checking casperjs"
#casperjs --version
echo 'secrets.json'
cat /etc/secrets/secret.json
echo '.env'
cat .env

bundle exec puma -p 5555 &
bundle exec puma -p 5556 &
echo "done started"
