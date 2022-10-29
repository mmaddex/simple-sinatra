#!/bin/bash

bundle exec puma -p 4000 &
bundle exec puma -p 5000 &
