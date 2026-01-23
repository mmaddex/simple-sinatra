#!/bin/sh

/src/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 & /src/tailscale up --authkey=${TS_AUTHKEY} --hostname=side-car
/src/tailscale serve --bg 80
echo Tailscale started

#ALL_PROXY=socks5://localhost:1055/ HTTP_PROXY=http://localhost:1055/ http_proxy=http://localhost:1055/ rackup -o 0.0.0.0
#ALL_PROXY=socks5://localhost:1055/ rackup -o 0.0.0.0 -p 80
ALL_PROXY=socks5://localhost:1055/ bundle exec puma -p 80
#rackup -o 0.0.0.0
