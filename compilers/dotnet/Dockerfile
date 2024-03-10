FROM ubuntu:focal-20240216
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y libicu66 libssl-dev wget

SHELL ["/bin/bash", "-c"]

# install dotnet 8
RUN (mkdir /opt/dotnet8 && cd /opt/dotnet8 && \
  wget https://download.visualstudio.microsoft.com/download/pr/85bcc525-4e9c-471e-9c1d-96259aa1a315/930833ef34f66fe9ee2643b0ba21621a/dotnet-sdk-8.0.201-linux-x64.tar.gz && tar -xvf dotnet-sdk-8.0.201-linux-x64.tar.gz && \
  rm dotnet-sdk-8.0.201-linux-x64.tar.gz)
