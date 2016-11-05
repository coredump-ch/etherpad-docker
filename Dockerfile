FROM node:6
MAINTAINER Danilo Bargen <mail@dbrgn.ch>

ENV ETHERPAD_VERSION 1.6.0

# Get Etherpad-lite's other dependencies
RUN apt-get update && \
    apt-get install -y gzip unzip git-core curl python libssl-dev pkg-config build-essential supervisor && \
    rm -r /var/lib/apt/lists/*

# Add supervisor config file
ADD supervisor.conf /etc/supervisor/supervisor.conf

# Switch to non-root user
RUN useradd -ms /bin/bash etherpad && \
    chgrp etherpad /opt && \
    chmod g+w /opt
USER etherpad

# Grab the desired version
WORKDIR /opt
RUN curl -SL \
    https://github.com/ether/etherpad-lite/archive/${ETHERPAD_VERSION}.zip \
    > etherpad.zip && unzip etherpad && rm etherpad.zip && \
    mv etherpad-lite-${ETHERPAD_VERSION} etherpad-lite

# Set work dir
WORKDIR /opt/etherpad-lite

# Install dependencies
RUN bin/installDeps.sh && \
    npm install sqlite3

# Add conf files
ADD settings.json settings.json

# Add entry point script
ADD entrypoint.sh /entrypoint.sh

EXPOSE 9001
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bin/run.sh"]
