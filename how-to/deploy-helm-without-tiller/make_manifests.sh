#!/bin/sh
CHART_NAME=$1
shift

rm -f -r ./manifests/$CHART_NAME
mkdir -p ./manifests
helm template \
  --output-dir ./manifests \
  $@ \
  ./charts/$CHART_NAME
