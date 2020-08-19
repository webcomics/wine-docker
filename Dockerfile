FROM debian:buster
MAINTAINER Tobias Gruetzmacher "tobias-docker@23.gs"

ARG BUILD_DATE
ARG VCS_REF
LABEL \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.license="MIT" \
  org.label-schema.name="Docker wine-staging" \
  org.label-schema.url="https://wine-staging.com/" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/TobiX/wine-staging"

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
		wine-staging:i386 \
		winehq-staging

ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
