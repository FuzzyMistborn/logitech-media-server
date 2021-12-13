FROM debian:bullseye-slim

ARG BUILD_DATE
ARG VCS_REF

LABEL \
  maintainer="FuzzyMistborn <fuzzy@fuzzymistborn.com>" \
  architecture="amd64/x86_64" \
  lms-version="8.3" \
  org.opencontainers.image.title="logitech-media-server" \
  org.opencontainers.image.authors="FuzzyMistborn <fuzzy@fuzzymistborn.com>" \
  org.opencontainers.image.description="For running Logitech Media Server" \
  org.opencontainers.image.source="https://github.com/FuzzyMistborn/logitech-media-server" \
  org.opencontainers.image.revision=$VCS_REF \
  org.opencontainers.image.created=$BUILD_DATE

SHELL [ "/bin/bash", "-c" ]

ENV LANG=C.UTF-8 \
    base_url="http://downloads.slimdevices.com/nightly/"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install \
      curl \
      faad \
      flac \
      lame \
      perl \
      sox \
      wget \
      libio-socket-ssl-perl \
      libcrypt-openssl-rsa-perl \
      libnet-ssleay-perl \
    && \
    rm -rf /var/lib/apt/lists/* && \
    curl -Lsf -o /tmp/logitechmediaserver.deb "${base_url}"$(curl -Lsf "${base_url}index.php?ver=8.3" | awk -F'"' '/_amd64.deb/ { print $2}') && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/logitechmediaserver.deb && \
    rm -f /tmp/logitechmediaserver.deb

EXPOSE 3483 3483/udp 9000 9090

COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "" ]
