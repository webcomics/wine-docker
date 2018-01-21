Docker wine-staging
===================

![license](https://img.shields.io/github/license/tobix/wine-staging.svg)
![Maintenance](https://img.shields.io/maintenance/yes/2018.svg)
![Docker Automated build](https://img.shields.io/docker/automated/tobix/wine-staging.svg)
[![](https://images.microbadger.com/badges/image/tobix/wine-staging.svg)](https://microbadger.com/images/tobix/wine-staging "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/tobix/wine-staging.svg)](https://microbadger.com/images/tobix/wine-staging "Get your own commit badge on microbadger.com")

This is docker container with wine-staging installed. See
http://wine-staging.com/ for details.

Since we assume people want to actually run stuff with wine, a user is created
and set as the default.

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
