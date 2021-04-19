FROM ubuntu:focal-20201008
ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y curl unzip zip wget g++ python python3 fp-compiler mono-complete apt-transport-https \
    binutils git gnupg2 libc6-dev libcurl4 libedit2 libgcc-9-dev libpython2.7 libsqlite3-0 libstdc++-9-dev libxml2 libz3-dev pkg-config tzdata zlib1g-dev \
    time nano htop mc php7.4-cli php7.4-bcmath php7.4-mbstring php7.4-intl php7.4-json \
    golang \
    ruby-full && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    apt-get autoclean && rm -rf /var/lib/apt/lists/*

# install PascalABC.NET
RUN (cd /opt && wget https://robocontest.uz/dist/PABCNETC.tar.gz && tar -xzf PABCNETC.tar.gz && rm PABCNETC.tar.gz) && \
     echo "alias pabcnetcclear='mono /opt/PABCNETC/pabcnetcclear.exe'" >> /etc/bash.bashrc

# install swift
RUN (cd /opt && wget https://swift.org/builds/swift-5.3.3-release/ubuntu2004/swift-5.3.3-RELEASE/swift-5.3.3-RELEASE-ubuntu20.04.tar.gz && \
     tar -xzf swift-5.3.3-RELEASE-ubuntu20.04.tar.gz && \
     rm swift-5.3.3-RELEASE-ubuntu20.04.tar.gz)

# install dart
RUN apt-get update && \
 sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
 sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' && \
 apt-get update && \
 apt-get install dart && \
 apt-get clean && \
 apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN export SDKMAN_DIR=/usr/local/sdkman && curl -s "https://get.sdkman.io" | bash
RUN source "$SDKMAN_DIR/bin/sdkman-init.sh"

RUN sdk install java 8.0.282.hs-adpt && ln -s $SDKMAN_DIR/candidates/java/8.0.282.hs-adpt/bin/ /opt/java8 && \
    sdk install java 11.0.10.hs-adpt && ln -s $SDKMAN_DIR/candidates/java/11.0.10.hs-adpt/bin/ /opt/java11 && \
    sdk install kotlin 1.3.72 && ln -s $SDKMAN_DIR/candidates/kotlin/1.3.72/bin/ /opt/kotlin && \
    sdk flush

ENV PATH $PATH:/opt/swift-5.3.3-RELEASE-ubuntu20.04/usr/bin
