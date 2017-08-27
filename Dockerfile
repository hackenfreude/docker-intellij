ARG OPENJDK_TAG=8u131-jdk

FROM buildpack-deps:stretch-curl as downloader

ARG INTELLIJ_VERSION=2017.2.2

ADD https://download.jetbrains.com/idea/ideaIC-${INTELLIJ_VERSION}.tar.gz.sha256 ideaIC-${INTELLIJ_VERSION}.tar.gz.sha256

ADD https://download.jetbrains.com/idea/ideaIC-${INTELLIJ_VERSION}.tar.gz ideaIC-${INTELLIJ_VERSION}.tar.gz

RUN sha256sum -c ideaIC-${INTELLIJ_VERSION}.tar.gz.sha256

RUN mkdir /opt/intellij && tar -C /opt/intellij --strip-components=1 -xvf /ideaIC-${INTELLIJ_VERSION}.tar.gz


FROM openjdk:${OPENJDK_TAG} as intellij

COPY --from=downloader /opt/intellij /opt/intellij

ENTRYPOINT ["/opt/intellij/bin/idea.sh"]
