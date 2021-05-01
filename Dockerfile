FROM debian:buster
MAINTAINER Tobias Gruetzmacher "tobias-docker@23.gs"

ARG WINEPKG=winehq-stable
ARG BUILD_DATE
ARG VCS_REF
LABEL \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.license="MIT" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/TobiX/wine-docker"

ENV DEBIAN_FRONTEND noninteractive

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /tini
RUN chmod +x /tini

COPY apt /etc/apt

RUN \
	dpkg --add-architecture i386 && \
	apt-get update -y && \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		unzip \
		xauth \
		xvfb

COPY fix-xvfb.sh /tmp/

RUN \
	/tmp/fix-xvfb.sh && \
	sed -i '/^Enabled:/ s/no/yes/' /etc/apt/sources.list.d/* && \
	apt-get update -y && \
	apt-get install -y --no-install-recommends \
		winehq-staging

ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
