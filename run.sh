#!/bin/bash

trap 'echo DOINGWHATEVERIWANT' SIGTERM SIGINT

echo "starting rackup"
bundle exec rackup
