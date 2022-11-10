FROM ubuntu:focal-20201008
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y libicu66 libssl-dev wget

# install dotnet 6
RUN (mkdir /opt/dotnet6 && cd /opt/dotnet6 && \
  wget https://download.visualstudio.microsoft.com/download/pr/1d2007d3-da35-48ad-80cc-a39cbc726908/1f3555baa8b14c3327bb4eaa570d7d07/dotnet-sdk-6.0.403-linux-x64.tar.gz && tar -xvf dotnet-sdk-6.0.403-linux-x64.tar.gz && \
  rm dotnet-sdk-6.0.403-linux-x64.tar.gz)
