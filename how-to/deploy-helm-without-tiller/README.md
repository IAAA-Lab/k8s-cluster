# Deploying Helm Charts without Tiller

First, fetch the chart locally with:

```sh
./fetch.sh $CHART_REPO $CHART_NAME
```

Then, create the manifests with:

```sh
./make_manifests.sh $CHART_NAME \
  --name $DEPLOY_NAME \
  --namespace $NAMESPACE \
  --set $VARIABLE=$VALUE
```
