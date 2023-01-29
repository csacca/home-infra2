#!/bin/bash
set -x

cd "$(mktemp -d)" &&
    curl -O -L "https://github.com/grafana/loki/releases/download/v2.7.2/logcli-linux-amd64.zip" &&
    unzip "logcli-linux-amd64.zip" &&
    cp "logcli-linux-amd64" "${HOME}/.local/bin/logcli" &&
    chmod a+x "${HOME}/.local/bin/logcli" &&
    echo 'eval "$(logcli --completion-script-bash)"' >>~/.bashrc
