#!/usr/bin/bash

# ask for version
echo "Enter version for image: (e.g. 7.0)"
read version

docker push adizbek/ubuntu-compilers:latest
docker push adizbek/ubuntu-compilers:$version

