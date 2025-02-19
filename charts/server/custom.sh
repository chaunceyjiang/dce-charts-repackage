#!/bin/bash

CHART_DIRECTORY=$1
[ ! -d "$CHART_DIRECTORY" ] && echo "custom shell: error, miss CHART_DIRECTORY $CHART_DIRECTORY " && exit 1

cd $CHART_DIRECTORY
echo "custom shell: CHART_DIRECTORY $CHART_DIRECTORY"
echo "CHART_DIRECTORY $(ls)"

#========================= add your customize bellow ====================
#===============================

set -o errexit
set -o pipefail
set -o nounset


APP_VERSION=` cat charts/server/Chart.yaml | grep appVersion | awk '{print $2}'`
sed -iE "s?tag:.*?tag: \"v${APP_VERSION}\"?g" values.yaml

yq -i ' .image.registry = "ghcr.m.daocloud.io" ' values.yaml

rm -f values.yamlE || true

