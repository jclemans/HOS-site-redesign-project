#!/bin/sh
# 
#RACK_ENV=production bin/rackup -p 40000 -E production >/dev/null &
#bin/rainbows -D -c rainbows_config.rb -E production -p 10000 >/dev/null &
bundle exec rainbows -D -c rainbows_config.rb -E production -p 10000 >/dev/null &
