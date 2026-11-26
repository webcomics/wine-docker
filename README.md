# Dockerfied wine & wine-staging

![License](https://img.shields.io/github/license/webcomics/wine-docker)
![GitHub last commit](https://img.shields.io/github/last-commit/webcomics/wine-docker)
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
| stable | The latest stable version of wine (at the time of writing, 11.0) |
| devel | The latest development version of wine |
| staging | The latest staging version of wine |

## "Virtual" GUI

Wine can run some Windows console software without a display, but whenever a
window needs to be opened, a display server (either X11 or Wayland) is
required. There are some ways to start a "virtual" display server.

Since those wrapers fork stuff into the background, we use [tini] as the
entrypoint, otherwise those scripts might hang.

[tini]: https://github.com/krallin/tini

### Headless Wayland server

This is the modern and preferred way. This container ships a custom tool (based
on the [xwayland-run] tool suite) called `wlwine-run`, which makes it simple to
run commands under wine while making sure everything terminates correctly. You
can use it like this:

```sh
wlwine-run wine foo.exe
```

or, for multiple commands:

```sh
wlwine-run sh -c "\
    wine foo.exe && \
    wine bar.exe"
```

[xwayland-run]: https://gitlab.freedesktop.org/ofourdan/xwayland-run

### Headless X11 via Xvfb

This way is deprecated and the tool might be removed in the future. If you use
this way, you have to cleanup wineserver yourself:

```sh
xvfb-run sh -c "\
  wine foo.exe && \
  wine bar.exe && \
  wineserver -w"
```
