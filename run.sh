#!/bin/sh

# Trap SIGTERM and SIGINT and define cleanup actions


pkill -f /opt/render-ssh/bin/sshd || true

echo "starting rackup"

# Start Puma as a background process
bundle exec puma
