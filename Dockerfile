FROM debian:trixie
LABEL org.opencontainers.image.authors="Tobias Gruetzmacher <tobias-docker@23.gs>"

ENV DEBIAN_FRONTEND=noninteractive

COPY apt /etc/apt
COPY fix-xvfb.sh wine-dependencies.txt /tmp/
COPY wlwine-run /usr/local/bin/

RUN \
	dpkg --add-architecture i386 \
	&& apt-get install -y --update --no-install-recommends \
		ca-certificates \
		curl \
		tini \
		unzip \
		weston \
		xauth \
		xvfb \
		xwayland-run \
	&& apt-get install -y --no-install-recommends --mark-auto \
		$(cat /tmp/wine-dependencies.txt) \
	&& rm /tmp/wine-dependencies.txt \
	&& /tmp/fix-xvfb.sh \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ARG WINE_FLAVOUR=devel

RUN \
	sed -i '/^Enabled:/ s/no/yes/' /etc/apt/sources.list.d/* \
	&& apt-get install -y --update --no-install-recommends \
		winehq-${WINE_FLAVOUR} \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]
