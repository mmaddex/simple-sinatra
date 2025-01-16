#!/bin/sh

# Trap SIGTERM and SIGINT and define cleanup actions
trap 'echo "DOINGWHATEVERIWANT"; kill -TERM "$child" 2>/dev/null' SIGTERM SIGINT

echo "starting rackup"

# Start Puma as a background process
bundle exec puma &

# Capture the child's PID
child=$!

# Wait for the child process to exit
wait "$child"
