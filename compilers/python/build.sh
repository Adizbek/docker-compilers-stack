#!/usr/bin/bash

# ask for version
echo "Enter version for image: (e.g. 7.0)"
read version

docker build --platform linux/amd64 -t adizbek/compiler-python:latest -t adizbek/compiler-python:$version .
