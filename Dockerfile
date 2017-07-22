FROM buildpack-deps:stretch-curl as downloader

ARG OPENJDK_TAG=8u131-jdk

ENV INTELLIJ_VERSION=2017.2

RUN wget --no-verbose https://download.jetbrains.com/idea/ideaIC-${INTELLIJ_VERSION}.tar.gz.sha256

RUN wget --no-verbose --show-progress --progress=dot:giga https://download.jetbrains.com/idea/ideaIC-${INTELLIJ_VERSION}.tar.gz

RUN sha256sum -c ideaIC-${INTELLIJ_VERSION}.tar.gz.sha256

RUN mkdir /opt/intellij && tar -C /opt/intellij --strip-components=1 -xvf /ideaIC-${INTELLIJ_VERSION}.tar.gz


FROM openjdk:${OPENJDK_TAG} as intellij

COPY --from=downloader /opt/intellij /opt/intellij

ENTRYPOINT ["/opt/intellij/bin/idea.sh"]
