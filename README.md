Docker wine-staging
===================

This is docker container with wine-staging installed. See
http://wine-staging.com/ for details.

Since we assume people want to actually want to run stuff with wine, a user is
created and set as the default.

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
