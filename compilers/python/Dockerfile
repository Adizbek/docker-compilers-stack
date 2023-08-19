FROM ubuntu:focal-20230801
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y libicu66 libssl-dev wget curl git  zip unzip build-essential libffi-dev libbz2-dev \
    liblzma-dev libsqlite3-dev libncurses5-dev libgdbm-dev zlib1g-dev libreadline-dev

#SHELL ["/bin/bash", "-c"]

ENV PYENV_ROOT /opt/pyenv

RUN curl -o pyenv-installer.sh https://pyenv.run && \
    chmod +x pyenv-installer.sh && \
    ./pyenv-installer.sh

ENV PATH "$PYENV_ROOT/bin:$PATH"

# includes pypy 3.10, python 3.11, python 2.7, graalpy 23 (python 3.10)

RUN pyenv install pypy3.10
RUN pyenv install 3.11
RUN pyenv install 2.7.18
RUN pyenv install graalpy-23.0.0

# All python version will be installed in $PYENV_ROOT/versions, copy them to /opt/python in your image
# PYENV_ROOT is /opt/pyenv