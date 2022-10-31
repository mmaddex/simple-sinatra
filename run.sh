#!/bin/bash

echo "starting on 4000"
bundle exec puma -p 4000 &
echo "starting on 5000"
bundle exec puma -p 5000 &
echo "done started"
