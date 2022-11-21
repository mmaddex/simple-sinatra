#!/bin/bash

./casperjs_env.sh
source ~/.bashrc

echo "starting on all the ports"
echo $SSH_VAR
echo $RAILS_ENV

echo "checking phantomjs"
phantomjs --version

echo "checking casperjs"
casperjs --version

bundle exec puma #-p 4000 & bundle exec puma -p 5000
echo "done started"
