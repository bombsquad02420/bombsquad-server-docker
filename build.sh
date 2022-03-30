#!/usr/bin/env bash

set -e

export changelog=`curl -s https://tools.ballistica.net/builds\?display\=changelog | grep -m 1 -o -P '<h3>\d+\.\d+\.\d+\W+\(\d+.*?\)<\/h3>'`
export version=`echo $changelog | grep -o -P '\d+\.\d+\.\d+'`
export buildnum=`echo $changelog | grep -o -P '\d{5,}'`
export fullversion=$version-$buildnum
echo $fullversion

export builds=`curl -s https://tools.ballistica.net/builds | grep -o -P '<tr.*?</tr>'`
export checksum_linux_x86_64=`echo $builds | grep -o -P '<tr.*?BombSquad_Server_Linux_x86_64_'${version}'.*?[0-9a-f]{40}' | grep -o -P '[0-9a-f]{40}' | tail -n 1`

mkdir -p ./downloads/linux/x86_64
wget https://files.ballistica.net/bombsquad/builds/BombSquad_Server_Linux_x86_64_${version}.tar.gz --no-check-certificate -O ./downloads/linux/x86_64/bombsquad-server.tar.gz
echo $checksum_linux_x86_64 ./downloads/linux/x86_64/bombsquad-server.tar.gz | sha1sum -c -

docker build --pull --tag bombsquad-server .

docker tag bombsquad-server aryan02420/bombsquad-server:latest
docker tag bombsquad-server aryan02420/bombsquad-server:$fullversion

sudo docker push aryan02420/bombsquad-server:latest
sudo docker push aryan02420/bombsquad-server:$fullversion