#!/bin/sh

# renovate: datasource=github-releases depName=siderolabs/talos
VERSION=v1.3.3

curl -Lo /usr/local/bin/talosctl https://github.com/siderolabs/talos/releases/download/${VERSION}/talosctl-$(uname -s | tr "[:upper:]" "[:lower:]")-amd64
chmod +x /usr/local/bin/talosctl
