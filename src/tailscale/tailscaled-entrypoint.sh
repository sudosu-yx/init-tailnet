#!/usr/bin/env bash


/usr/local/sbin/tailscaled-devcontainer-start

unset TS_AUTH_KEY

exec "$@"
