#!/bin/bash

bundle exec puma -p 3000 &
bundle exec puma -p 2000 &
