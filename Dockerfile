FROM ubuntu:bionic-20200723

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y curl unzip zip wget
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN cd /usr/lib && \
    wget -q 'https://github.com/JetBrains/kotlin/releases/download/v1.3.72/kotlin-compiler-1.3.72.zip' && \
    unzip kotlin-compiler-*.zip && \
    rm kotlin-compiler-*.zip && \
    rm -f kotlinc/bin/*.bat

ENV PATH $PATH:/usr/lib/kotlinc/bin

RUN apt-get install -y default-jdk-headless g++ python python3 nodejs fp-compiler mono-complete time
RUN apt-get install -y nano php7.2-cli php7.2-bcmath php7.2-mbstring php7.2-intl php7.2-json golang

# install PascalABC.NET
COPY compilers/PABCNETC.zip /opt
RUN unzip /opt/PABCNETC.zip -d /opt/PABCNETC && rm /opt/PABCNETC.zip

RUN echo "alias pabcnetcclear='mono /opt/PABCNETC/pabcnetcclear.exe'" >> /etc/bash.bashrc

RUN rm -rf /var/lib/apt/lists/*
