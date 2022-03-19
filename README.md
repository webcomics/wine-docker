# Dockerfied wine & wine-staging

![License](https://img.shields.io/github/license/webcomics/wine-docker)
![Maintenance](https://img.shields.io/maintenance/yes/2022)
[![Docker image](https://github.com/webcomics/wine-docker/actions/workflows/deploy.yaml/badge.svg)](https://github.com/webcomics/wine-docker/actions/workflows/deploy.yaml)
![Docker Image Size (stable)](https://img.shields.io/docker/image-size/tobix/wine/stable?label=size%20%28stable%29)
![Docker Image Size (devel)](https://img.shields.io/docker/image-size/tobix/wine/devel?label=size%20%28devel%29)
![Docker Image Size (staging)](https://img.shields.io/docker/image-size/tobix/wine/staging?label=size%20%28staging%29)

This is a docker container with wine or wine-staging installed. See
https://www.winehq.org/ https://wine-staging.com/ for details.

## Tags

This repository provides different tags for different versions of Wine:

| Tag | Version |
| --- | --- |
| stable | The latest stable version of wine (at the time of writing, 7.0) |
| devel | The latest development version of wine |
| staging | The latest staging version of wine |

## UI via Xvfb

Xvfb is installed if you need to run something with GUI. Prepend your commands
with xvfb-run to use it. Since xvfb-run forks the real Xvfb binary, [tini] is
used as an entrypoint, otherwise xvfb-run hangs.

If you want to run multiple wine processes with Xvfb, wrap then in one Xvfb
call instead of spawning multiple Xvfb instances:

    xvfb-run sh -c "\
      wine foo.exe && \
      wine bar.exe && \
      wineserver -w"

[tini]: https://github.com/krallin/tini
