FROM gitpod/workspace-full

# FLutter
ENV FLUTTER_HOME=/home/gitpod/flutter
ENV FLUTTER_VERSION=1.22.2-stable
# Android
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV ANDROID_HOME /opt/android-sdk-linux

# RUN mkdir Android && \
#     wget -qO cli.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip && \
#     unzip cli.zip && \
#     rm cli.zip && \
#     mv cmdline-tools Android/

# ENV ANDROID_SDK_ROOT =

# Install dart
USER root

# RUN apt update -qq && apt install zip unzip
# Install Android SDK
RUN cd /opt && \
    wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip -q *.zip -d ${ANDROID_HOME} && \
    rm *.zip

RUN chmod -R 777 ${ANDROID_HOME}
RUN cd /

RUN apt clean -qq

RUN apt-get update -y
RUN apt-get install -y gcc make build-essential wget curl unzip apt-utils xz-utils libkrb5-dev gradle libpulse0 android-tools-adb android-tools-fastboot
RUN apt-get install -y openjdk-8-jdk

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    apt-get update && \
    apt-get -y install libpulse0 build-essential libkrb5-dev gcc make && \
    apt-get clean && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*;

USER gitpod

# Install Flutter sdk
RUN cd /home/gitpod && \
  wget -qO flutter_sdk.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz && \
  tar -xvf flutter_sdk.tar.xz && rm flutter_sdk.tar.xz

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools
# RUN yes "y" | $FLUTTER_HOME/bin/flutter doctor --android-licenses -v

# Change the PUB_CACHE to /workspace so dependencies are preserved.
ENV PUB_CACHE=/workspace/.pub_cache

# add executables to PATH
RUN echo 'export PATH=${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PUB_CACHE}/bin:${FLUTTER_HOME}/.pub-cache/bin:$PATH' >>~/.bashrc
