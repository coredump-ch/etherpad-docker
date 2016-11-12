#!/bin/bash
set -e

# Update settings.json
: ${ETHERPAD_TITLE:=Etherpad}
: ${ETHERPAD_SESSION_KEY:=$(
		node -p "require('crypto').randomBytes(32).toString('hex')")}
: ${ETHERPAD_ADMIN_PASS:=$(
		node -p "require('crypto').randomBytes(16).toString('hex')")}
: ${ETHERPAD_FOOTER:=""}
sed -i "s/{{ETHERPAD_TITLE}}/${ETHERPAD_TITLE}/" settings.json
sed -i "s/{{ETHERPAD_SESSION_KEY}}/${ETHERPAD_SESSION_KEY}/" settings.json
sed -i "s/{{ETHERPAD_ADMIN_PASS}}/${ETHERPAD_ADMIN_PASS}/" settings.json
sed -i "s/{{ETHERPAD_FOOTER}}/${ETHERPAD_FOOTER//\//\\/}/" settings.json

exec "$@"
