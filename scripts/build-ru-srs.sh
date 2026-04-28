#!/usr/bin/env bash
set -euo pipefail

GEOIP_URL="https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/geoip.dat"
GEOSITE_URL="https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/geosite.dat"

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

GO111MODULE=on go run github.com/runetfreedom/geodat2srs@latest geoip \
  -i "$GEOIP_URL" \
  -o "$workdir" \
  --prefix "geoip-"

GO111MODULE=on go run github.com/runetfreedom/geodat2srs@latest geosite \
  -i "$GEOSITE_URL" \
  -o "$workdir" \
  --prefix "geosite-"

cp "$workdir/geoip-ru.srs" "geoip-ru.srs"
cp "$workdir/geosite-ru-available-only-inside.srs" "geosite-ru-available-only-inside.srs"
cp "$workdir/geosite-ru-available-only-inside.srs" "geosite-ru-available-onely-inside.srs"
