FROM node:6
MAINTAINER Danilo Bargen <mail@dbrgn.ch>

ENV ETHERPAD_VERSION 1.6.0

# Get Etherpad-lite's other dependencies
RUN apt-get update && \
    apt-get install -y gzip unzip git-core curl python libssl-dev pkg-config build-essential supervisor && \
    rm -r /var/lib/apt/lists/*

# Set work dir
WORKDIR /opt

# Grab the desired version
RUN curl -SL \
    https://github.com/ether/etherpad-lite/archive/${ETHERPAD_VERSION}.zip \
    > etherpad.zip && unzip etherpad && rm etherpad.zip && \
    mv etherpad-lite-${ETHERPAD_VERSION} etherpad-lite

# Install dependencies
RUN /opt/etherpad-lite/bin/installDeps.sh

# Add conf files
ADD settings.json /opt/etherpad-lite/settings.json
ADD supervisor.conf /etc/supervisor/supervisor.conf

# Update admin password
RUN sed -i "s/{{ADMIN_PASSWORD}}/${ADMIN_PASSWORD}/g" /opt/etherpad-lite/settings.json

EXPOSE 9001
CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf", "-n"]
