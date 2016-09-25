FROM debian
MAINTAINER Tobias Gruetzmacher "tobias-docker@23.gs"

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 && \
	apt-get update -y && \
	apt-get install -y --no-install-recommends \
		apt-transport-https \
		ca-certificates \
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

ENTRYPOINT ["xvfb-run"]
CMD ["/bin/bash"]
