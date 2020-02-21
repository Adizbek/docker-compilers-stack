FROM ubuntu:focal

RUN apt-get update

RUN apt-get install -y g++ python2 python3
RUN apt-get install -y default-jdk
RUN apt-get install -y nodejs npm

RUN apt-get install -y time

RUN rm -rf /var/lib/apt/lists/*
