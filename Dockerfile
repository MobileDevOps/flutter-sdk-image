FROM mobiledevops/android-sdk-image:36.1.0

ENV FLUTTER_VERSION="3.44.4"
ENV FLUTTER_HOME="/home/mobiledevops/.flutter-sdk"
ENV PATH="$PATH:$FLUTTER_HOME/bin"

# Download and extract Flutter SDK
RUN mkdir $FLUTTER_HOME \
    && cd $FLUTTER_HOME \
    && curl --fail --remote-time --silent --location -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz --strip-components=1 \
    && rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

# Git safe.directory for the extracted SDK (required since git 2.35+ ownership checks)
RUN git config --global --add safe.directory $FLUTTER_HOME

RUN flutter precache
