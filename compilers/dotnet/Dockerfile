FROM ubuntu:focal-20230801
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y libicu66 libssl-dev wget

SHELL ["/bin/bash", "-c"]

# install dotnet 7
RUN (mkdir /opt/dotnet7 && cd /opt/dotnet7 && \
  wget https://download.visualstudio.microsoft.com/download/pr/dbfe6cc7-dd82-4cec-b267-31ed988b1652/c60ab4793c3714be878abcb9aa834b63/dotnet-sdk-7.0.400-linux-x64.tar.gz && tar -xvf dotnet-sdk-7.0.400-linux-x64.tar.gz && \
  rm dotnet-sdk-7.0.400-linux-x64.tar.gz)
