FROM ubuntu:focal-20201008
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl unzip zip wget default-jdk-headless g++ python python3 fp-compiler mono-complete apt-transport-https \
    #swift
    binutils git gnupg2 libc6-dev libcurl4 libedit2 libgcc-9-dev libpython2.7 libsqlite3-0 libstdc++-9-dev libxml2 libz3-dev pkg-config tzdata zlib1g-dev \
    time nano htop mc php7.4-cli php7.4-bcmath php7.4-mbstring php7.4-intl php7.4-json \
    golang \
    ruby-full && \
    # install dart
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN cd /usr/lib && \
    wget -q 'https://github.com/JetBrains/kotlin/releases/download/v1.3.72/kotlin-compiler-1.3.72.zip' && \
    unzip kotlin-compiler-*.zip && \
    rm kotlin-compiler-*.zip && \
    rm -f kotlinc/bin/*.bat

ENV PATH $PATH:/usr/lib/kotlinc/bin

# install PascalABC.NET
ADD compilers/PABCNETC.tar.gz /opt/
ADD compilers/swift-5.3.3-RELEASE-ubuntu20.04.tar.gz /usr/lib

RUN apt-get update && \
 sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
 sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' && \
 apt-get update && \
 apt-get install dart && \
 apt-get clean && \
 apt-get autoclean && rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:/usr/lib/swift-5.3.3-RELEASE-ubuntu20.04/usr/bin

RUN echo "alias pabcnetcclear='mono /opt/PABCNETC/pabcnetcclear.exe'" >> /etc/bash.bashrc
