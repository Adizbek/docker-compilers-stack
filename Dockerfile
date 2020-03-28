FROM ubuntu:bionic

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get install -y default-jdk g++ python python3 nodejs fp-compiler mono-complete time
RUN apt-get install -y nano unzip

# install PascalABC.NET
COPY compilers/PABCNETC.zip /opt
RUN unzip /opt/PABCNETC.zip -d /opt/PABCNETC && rm /opt/PABCNETC.zip

RUN echo "alias pabcnetcclear='mono /opt/PABCNETC/pabcnetcclear.exe'" >> /etc/bash.bashrc

RUN rm -rf /var/lib/apt/lists/*
