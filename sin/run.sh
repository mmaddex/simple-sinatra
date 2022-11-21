#!/bin/bash

./casperjs_env.sh

echo "starting on all the ports"
echo $SSH_VAR
echo $RAILS_ENV
bundle exec puma #-p 4000 & bundle exec puma -p 5000
echo "done started"
