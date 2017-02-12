FROM debian:jessie
MAINTAINER Tobias Gruetzmacher "tobias-docker@23.gs"

ARG BUILD_DATE
ARG VCS_REF
LABEL \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.license="MIT" \
  org.label-schema.name="Docker wine-staging" \
  org.label-schema.url="http://wine-staging.com/" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/TobiX/wine-staging"

ENV DEBIAN_FRONTEND noninteractive

ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN dpkg --add-architecture i386 && \
	apt-get update -y && \
	apt-get install -y --no-install-recommends \
		apt-transport-https \
		ca-certificates \
		curl \
		xauth \
		xvfb

COPY staging.list /etc/apt/sources.list.d/
COPY staging.gpg /etc/apt/trusted.gpg.d/

RUN apt-get update -y && \
	apt-get install -y --no-install-recommends \
		wine-staging:i386 \
		winehq-staging

RUN useradd -m user
USER user

ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
