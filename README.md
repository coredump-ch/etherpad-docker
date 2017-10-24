etherpad-docker
===============

Based on https://github.com/ether/etherpad-docker.

Among other things, changed database engine to SQLite. Furthermore, the process
inside Docker runs as non-root.

To start:

    docker run -d \
        -p 9001:9001 \
        -e ETHERPAD_ADMIN_PASS="adminpassword" \
        -v /local/data/dir:/opt/etherpad-lite-data \
        <image>

Make sure that the mount directory for the data dir is writeable by user with
uid `1000`.

Other config vars:

- `ETHERPAD_TITLE`
- `ETHERPAD_SESSION_KEY`
- `ETHERPAD_FOOTER`
- `ETHERPAD_WELCOME_TEXT`
