FROM ubuntu:focal-20201008
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl unzip zip wget apt-transport-https g++ python python3 fp-compiler mono-complete \
    binutils git gnupg2 libc6-dev libcurl4 libedit2 libgcc-9-dev libpython2.7 libsqlite3-0 libstdc++-9-dev libxml2 libz3-dev pkg-config tzdata zlib1g-dev \
    time nano htop mc php7.4-cli php7.4-bcmath php7.4-mbstring php7.4-intl php7.4-json \
    ruby-full && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    apt-get autoclean && rm -rf /var/lib/apt/lists/*

# install PascalABC.NET, dist from robocontest.uz site.
RUN (cd /opt && wget https://robocontest.uz/dist/PABCNETC.tar.gz && tar -xzf PABCNETC.tar.gz && rm PABCNETC.tar.gz) && \
     echo "alias pabcnetcclear='mono /opt/PABCNETC/pabcnetcclear.exe'" >> /etc/bash.bashrc

# install golang
RUN (cd /opt && wget https://dl.google.com/go/go1.18.3.linux-amd64.tar.gz && tar -xvf go1.18.3.linux-amd64.tar.gz && mv go /usr/local && rm /opt/go1.18.3.linux-amd64.tar.gz)

# install dart
RUN apt-get update && \
 sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
 sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' && \
 apt-get update && \
 apt-get install dart && \
 apt-get clean && \
 apt-get autoclean && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

ENV SDKMAN_DIR /usr/local/sdkman
RUN curl -s "https://get.sdkman.io" | bash

RUN source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 8.0.282.hs-adpt && ln -s $SDKMAN_DIR/candidates/java/8.0.282.hs-adpt/bin/ /opt/java8 && \
    sdk install java 17.0.3-tem && ln -s $SDKMAN_DIR/candidates/java/17.0.3-tem/bin/ /opt/java17 && \
    sdk install java 11.0.11.hs-adpt && ln -s $SDKMAN_DIR/candidates/java/11.0.11.hs-adpt/bin/ /opt/java11 && \
    sdk install kotlin 1.3.72 && ln -s $SDKMAN_DIR/candidates/kotlin/1.3.72/bin/ /opt/kotlin && \
    sdk flush

# install swift
RUN (cd /opt && wget https://swift.org/builds/swift-5.3.3-release/ubuntu2004/swift-5.3.3-RELEASE/swift-5.3.3-RELEASE-ubuntu20.04.tar.gz && \
     tar -xzf swift-5.3.3-RELEASE-ubuntu20.04.tar.gz && \
     rm swift-5.3.3-RELEASE-ubuntu20.04.tar.gz)

RUN echo "alias java8='/opt/java8/java'" >> /etc/bash.bashrc

COPY --from=adizbek/compiler-dotnet6 /opt/dotnet6 /opt/dotnet6

RUN (cd /opt && wget https://downloads.python.org/pypy/pypy3.9-v7.3.9-linux64.tar.bz2 && \
    tar -xzf pypy3.9-v7.3.9-linux64.tar.bz2 && \
         rm pypy3.9-v7.3.9-linux64.tar.bz2)

ENV DOTNET_ROOT /opt/dotnet6
ENV GOROOT /usr/local/go
ENV PATH $PATH:/opt/pypy3.9-v7.3.9-linux64/bin:/opt/swift-5.3.3-RELEASE-ubuntu20.04/usr/bin:/opt/kotlin:$GOROOT/bin:$DOTNET_ROOT
