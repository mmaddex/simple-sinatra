#!/bin/bash

#./casperjs_env.sh
#source ~/.bashrc

echo "starting on all the ports"
echo $SSH_VAR
echo $RAILS_ENV

#echo "checking phantomjs"
#phantomjs --version

#echo "checking casperjs"
#casperjs --version

echo catfile
cat file.txt
bundle exec puma #& bundle exec puma -p 92
echo "done started"
