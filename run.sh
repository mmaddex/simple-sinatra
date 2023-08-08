#!/bin/bash

#touch ~/.irbrc_run && echo "IRB.conf[:USE_AUTOCOMPLETE] = false" >> ~/.irbrc_run
#cat ~/.irbrc_run

#./casperjs_env.sh
#source ~/.bashrc

echo "starting on all the ports"
echo $RENDER_INSTANCE_ID
echo $RENDER_SERVICE_ID
echo $SSH_VAR
echo $RAILS_ENV
#echo 'testmd'
#cat test.md

#echo "checking phantomjs"
#phantomjs --version

#echo "checking casperjs"
#casperjs --version
#echo 'secrets.json'
#cat /etc/secrets/secret.json
#echo '.env'
#cat .env

# set -x
bundle exec puma -p 80
# & bundle exec puma -p 5557
#bundle exec puma
#echo "done started"
#ps -ef | grep puma

#touch ~/.irbrc_run && echo "IRB.conf[:USE_AUTOCOMPLETE] = false" >> ~/.irbrc_run
