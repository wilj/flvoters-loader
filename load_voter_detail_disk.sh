#!/usr/bin/env bash
set -euxo pipefail
TMP=/tmp/flvoters
rm -rf $TMP
unzip $(find $1 -iname "*voterdetail.zip" | head -n1) -d $TMP

./reload_schema.sh

./load_voter_detail_dir.sh $TMP

