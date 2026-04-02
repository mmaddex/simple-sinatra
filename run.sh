#!/bin/sh

# Trap SIGTERM and SIGINT and define cleanup actions


echo "starting rackup"

# Start Puma as a background process
bundle exec puma
