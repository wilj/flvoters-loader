#!/usr/bin/env bash
set -euxo pipefail

# load each file
find $1 -type f -print0 | sort -z | while read -d $'\0' f
do 
  echo "Loading $f"
  ./load_voter_detail_file.sh "$f"
done

