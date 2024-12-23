FROM debian:bookworm
LABEL org.opencontainers.image.authors="Tobias Gruetzmacher <tobias-docker@23.gs>"

ENV DEBIAN_FRONTEND=noninteractive

# renovate: datasource=github-releases depName=krallin/tini
ARG TINI_VERSION=0.19.0

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY apt /etc/apt

RUN \
	dpkg --add-architecture i386 \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		libvulkan1 \
		unzip \
		xauth \
		xvfb \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY fix-xvfb.sh /tmp/

ARG WINE_FLAVOUR=stable

RUN \
	/tmp/fix-xvfb.sh \
	&& sed -i '/^Enabled:/ s/no/yes/' /etc/apt/sources.list.d/* \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends \
		winehq-${WINE_FLAVOUR} \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
