#/bin/sh
REPO_URI=$1
CHART_NAME=$2

helm fetch \
--repo $REPO_URI \
--untar \
--untardir ./charts \
$CHART_NAME \
# && \
# \
# mkdir -p ./values && \
# cp -n ./charts/$CHART_NAME/values.yaml ./values/$CHART_NAME.yaml
