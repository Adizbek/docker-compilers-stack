FROM ubuntu:bionic

RUN apt-get update

RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get install -y default-jdk
RUN apt-get install -y g++ python python3
RUN apt-get install -y nodejs
RUN apt-get install -y fp-compiler
RUN apt-get install -y mono-complete

RUN apt-get install -y time

RUN rm -rf /var/lib/apt/lists/*
