# Docker wine-staging

![License](https://img.shields.io/github/license/webcomics/wine-staging)
![Maintenance](https://img.shields.io/maintenance/yes/2020)
![Docker Automated build](https://img.shields.io/docker/automated/tobix/wine-staging)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tobix/wine-staging/latest)

This is docker container with wine-staging installed. See
https://wine-staging.com/ for details.

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
