#!/bin/bash


set -e

source dev-container-features-test-lib

check "daemon is running" tailscale version --daemon

if [[ -n "$VERSION" ]]; then
    check "version is correct" bash -c "tailscale version --daemon | grep -q $VERSION"
fi

reportResults