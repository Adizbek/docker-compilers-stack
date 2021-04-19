FROM ubuntu:focal-20201008
ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y curl unzip zip wget g++ python python3 fp-compiler mono-complete apt-transport-https \
    binutils git gnupg2 libc6-dev libcurl4 libedit2 libgcc-9-dev libpython2.7 libsqlite3-0 libstdc++-9-dev libxml2 libz3-dev pkg-config tzdata zlib1g-dev \
    time nano htop mc php7.4-cli php7.4-bcmath php7.4-mbstring php7.4-intl php7.4-json \
    golang \
    ruby-full && \
    # install dart
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    apt-get autoclean && rm -rf /var/lib/apt/lists/*

ENV SDKMAN_DIR /usr/local/sdkman
RUN curl -s "https://get.sdkman.io" | bash && \
    source /usr/local/sdkman/bin/sdkman-init.sh && \
    sdk install java 8.0.282.hs-adpt && ln -s /usr/local/sdkman/candidates/java/8.0.282.hs-adpt/bin/ /opt/java8 && \
    sdk install java 11.0.10.hs-adpt && ln -s /usr/local/sdkman/candidates/java/11.0.10.hs-adpt/bin/ /opt/java11 && \
    sdk install kotlin 1.4.31 && ln -s /usr/local/sdkman/candidates/kotlin/1.4.31/bin/ /opt/kotlin1.4 && \
    sdk flush


# install PascalABC.NET
ADD https://robocontest.uz/dist/PABCNETC.tar.gz /opt/
# install swift
ADD https://swift.org/builds/swift-5.3.3-release/ubuntu2004/swift-5.3.3-RELEASE/swift-5.3.3-RELEASE-ubuntu20.04.tar.gz /usr/lib

RUN apt-get update && \
 sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
 sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' && \
 apt-get update && \
 apt-get install dart && \
 apt-get clean && \
 apt-get autoclean && rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:/usr/lib/swift-5.3.3-RELEASE-ubuntu20.04/usr/bin

RUN echo "alias pabcnetcclear='mono /opt/PABCNETC/pabcnetcclear.exe'" >> /etc/bash.bashrc
