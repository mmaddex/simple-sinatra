#!/bin/bash

echo "starting on all the ports"
bundle exec puma -p 4000 & bundle exec puma -p 5000
echo "done started"
