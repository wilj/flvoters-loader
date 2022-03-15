#!/usr/bin/env bash
set -euxo pipefail
(cd flvoters/ && dolt sql - < ../flvoters.sql)
