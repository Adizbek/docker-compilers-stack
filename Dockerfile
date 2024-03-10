FROM ubuntu:focal-20240216

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt upgrade -y && \
    apt-get install -y iptables curl unzip zip wget apt-transport-https g++ python python3 fp-compiler mono-complete \
    binutils git gnupg2 libc6-dev libcurl4 libedit2 libgcc-9-dev libpython2.7 libsqlite3-0 libstdc++-9-dev  \
    libicu66 libssl-dev build-essential  libffi-dev libgmp-dev \
    libgmp10 libncurses-dev libncurses5 libtinfo5 libxml2 libz3-dev pkg-config tzdata zlib1g-dev \
    time nano htop mc php7.4-cli php7.4-bcmath php7.4-mbstring php7.4-intl php7.4-json \
    ruby-full && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    apt-get autoclean && rm -rf /var/lib/apt/lists/*

# install PascalABC.NET, dist from robocontest.uz site.
RUN (cd /opt && wget https://robocontest.uz/dist/PABCNETC.tar.gz && tar -xzf PABCNETC.tar.gz && rm PABCNETC.tar.gz) && \
     echo "alias pabcnetcclear='mono /opt/PABCNETC/pabcnetcclear.exe'" >> /etc/bash.bashrc

# install rust
ENV CARGO_HOME /opt/rust/cargo
ENV RUSTUP_HOME /opt/rust/rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

# install haskell
ENV GHCUP_INSTALL_BASE_PREFIX /opt/haskell
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | bash -s -- -y


# install golang
RUN (cd /opt && wget https://dl.google.com/go/go1.20.3.linux-amd64.tar.gz && tar -xvf go1.20.3.linux-amd64.tar.gz && mv go /usr/local && rm /opt/go1.20.3.linux-amd64.tar.gz)

# install dart
RUN apt-get update && \
 sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
 sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' && \
 apt-get update && \
 apt-get install dart && \
 apt-get clean && \
 apt-get autoclean && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

# install swift
RUN (cd /opt && wget https://download.swift.org/swift-5.8-release/ubuntu2004/swift-5.8-RELEASE/swift-5.8-RELEASE-ubuntu20.04.tar.gz && \
     tar -xzf swift-5.8-RELEASE-ubuntu20.04.tar.gz && \
     rm swift-5.8-RELEASE-ubuntu20.04.tar.gz)

COPY --from=adizbek/compiler-dotnet:8.0 /opt/dotnet8 /opt/dotnet8

# includes java 20, java-20-graal, java 11, java 8, kotlin 8
COPY --from=adizbek/compiler-sdkman:1.2 /opt /opt

# includes pypy 3.10, python 3.11, python 2.7, graalpy 23 (python 3.10)
COPY --from=adizbek/compiler-python:1.3 /opt/pyenv/versions /opt/pyenv/versions

ENV DOTNET_ROOT /opt/dotnet8
ENV GOROOT /usr/local/go
ENV PATH $PATH:/opt/swift-5.8-RELEASE-ubuntu20.04/usr/bin:/opt/kotlin:$GOROOT/bin:$DOTNET_ROOT
