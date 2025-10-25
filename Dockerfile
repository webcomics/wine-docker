FROM debian:trixie
LABEL org.opencontainers.image.authors="Tobias Gruetzmacher <tobias-docker@23.gs>"

ENV DEBIAN_FRONTEND=noninteractive

# renovate: datasource=github-releases depName=krallin/tini
ARG TINI_VERSION=0.19.0

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY apt /etc/apt
COPY fix-xvfb.sh /tmp/

RUN \
	dpkg --add-architecture i386 \
	&& apt-get install -y --update --no-install-recommends \
		ca-certificates \
		curl \
		unzip \
		xauth \
		xvfb \
	&& /tmp/fix-xvfb.sh \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ARG WINE_FLAVOUR=stable

RUN \
	sed -i '/^Enabled:/ s/no/yes/' /etc/apt/sources.list.d/* \
	&& apt-get install -y --update --no-install-recommends \
		winehq-${WINE_FLAVOUR} \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
