#!/bin/bash

./casperjs_env.sh
source ~/.bashrc

echo "starting on all the ports"
echo $SSH_VAR
echo $RAILS_ENV

echo "setting locales"
dpkg-reconfigure locales

echo "checking phantomjs"
phantomjs --version

echo "checking casperjs"
casperjs --version

bundle exec puma -p 80 #& bundle exec puma -p 92
echo "done started"
