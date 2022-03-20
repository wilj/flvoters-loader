#!/usr/bin/env bash
set -euo pipefail

while true; do
    echo "$(date '+%Y-%m-%d %H:%M:%S') $(free -m | grep Mem: | sed 's/Mem://g' | awk '{ print $NF }' )"
    sleep 1
done
