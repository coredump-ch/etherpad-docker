etherpad-docker
===============

Based on https://github.com/ether/etherpad-docker.

Among other things, changed database engine to SQLite.

To start:

    docker run -d \
        -p 9001:9001 \
        -e ADMIN_PASSWORD="adminpassword" \
        -v /local/data/dir:/opt/etherpad-lite-data \
        <image>
