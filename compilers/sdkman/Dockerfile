FROM ubuntu:focal-20240216
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y libicu66 libssl-dev wget curl zip unzip

SHELL ["/bin/bash", "-c"]

# install java 20, java-20-graal, java 11, java 8, kotlin 8
ENV SDKMAN_DIR /opt/sdkman
RUN curl -s "https://get.sdkman.io" | bash

RUN source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 8.0.282.hs-adpt && \
    sdk install java 20.0.2-graal && \
    sdk install java 20-tem && \
    sdk install java 11.0.11.hs-adpt && \
    sdk install kotlin 1.9.0 && \
    sdk flush

RUN ln -s $SDKMAN_DIR/candidates/java/8.0.282.hs-adpt/bin/ /opt/java8 && \
    ln -s $SDKMAN_DIR/candidates/java/20.0.2-graal/bin/ /opt/java20-graal && \
    ln -s $SDKMAN_DIR/candidates/java/20-tem/bin/ /opt/java20 && \
    ln -s $SDKMAN_DIR/candidates/java/11.0.11.hs-adpt/bin/ /opt/java11 && \
    ln -s $SDKMAN_DIR/candidates/kotlin/1.9.0/bin/ /opt/kotlin