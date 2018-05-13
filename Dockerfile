ARG OPENJDK_TAG=8u171-jdk

FROM buildpack-deps:stretch-curl as downloader

ARG INTELLIJ_VERSION=2018.1

ADD https://download.jetbrains.com/idea/ideaIC-${INTELLIJ_VERSION}.tar.gz.sha256 ideaIC-${INTELLIJ_VERSION}.tar.gz.sha256

ADD https://download.jetbrains.com/idea/ideaIC-${INTELLIJ_VERSION}.tar.gz ideaIC-${INTELLIJ_VERSION}.tar.gz

RUN sha256sum -c ideaIC-${INTELLIJ_VERSION}.tar.gz.sha256

RUN mkdir /opt/intellij && tar -C /opt/intellij --strip-components=1 -xvf /ideaIC-${INTELLIJ_VERSION}.tar.gz


FROM openjdk:${OPENJDK_TAG} as intellij

RUN apt-get --quiet update && DEBIAN_FRONTEND=noninteractive apt-get --quiet --assume-yes install libgtk-3-0 libdbus-glib-1-2 libxt6 libcanberra-gtk-module libcanberra-gtk3-module

COPY --from=downloader /opt/intellij /opt/intellij

ENTRYPOINT ["/opt/intellij/bin/idea.sh"]
