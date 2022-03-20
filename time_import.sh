#!/usr/bin/env bash
set -euo pipefail

echo "$(date '+%Y-%m-%d %H:%M:%S') - import started"
./load_voter_extract.sh ~/workspace/loadvoters/raw/ > tmp/import.log
echo "$(date '+%Y-%m-%d %H:%M:%S') - import complete"
