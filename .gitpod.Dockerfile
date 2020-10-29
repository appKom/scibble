FROM gitpod/workspace-full

# FLutter
ENV FLUTTER_HOME=/home/gitpod/flutter
ENV FLUTTER_VERSION=1.22.2-stable
# Android
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV ANDROID_HOME="/home/gitpod/.android"
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ENV ANDROID_SDK_ARCHIVE="${ANDROID_HOME}/archive"
ENV ANDROID_STUDIO_PATH="/home/gitpod/"



# Install dart
USER root

RUN apt-get update -y
RUN apt-get install -y gcc make build-essential wget curl unzip apt-utils xz-utils libkrb5-dev gradle libpulse0 android-tools-adb android-tools-fastboot
RUN apt remove --purge openjdk-*-jdk
RUN apt-get install -y openjdk-8-jdk

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    apt-get update && \
    apt-get -y install libpulse0 build-essential libkrb5-dev gcc make && \
    apt-get clean && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*;

USER gitpod

RUN cd "${ANDROID_STUDIO_PATH}"
RUN wget -qO android_studio.zip https://dl.google.com/dl/android/studio/ide-zips/3.3.0.20/android-studio-ide-182.5199772-linux.zip
RUN unzip android_studio.zip
RUN rm -f android_studio.zip

RUN mkdir -p "${ANDROID_HOME}"
RUN touch $ANDROID_HOME/repositories.cfg
RUN wget -q "${ANDROID_SDK_URL}" -O "${ANDROID_SDK_ARCHIVE}"
RUN unzip -q -d "${ANDROID_HOME}" "${ANDROID_SDK_ARCHIVE}"
RUN echo y | "${ANDROID_HOME}/tools/bin/sdkmanager" "platform-tools" "platforms;android-28" "build-tools;28.0.3"
RUN rm "${ANDROID_SDK_ARCHIVE}"

# Install Flutter sdk
RUN cd /home/gitpod && \
  wget -qO flutter_sdk.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz && \
  tar -xvf flutter_sdk.tar.xz && rm flutter_sdk.tar.xz

RUN yes "y" | $FLUTTER_HOME/bin/flutter doctor --android-licenses -v

# Change the PUB_CACHE to /workspace so dependencies are preserved.
ENV PUB_CACHE=/workspace/.pub_cache

# add executables to PATH
RUN echo 'export PATH=${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PUB_CACHE}/bin:${FLUTTER_HOME}/.pub-cache/bin:$PATH' >>~/.bashrc
