# Avocado Example

This example deploys an nginx server that takes the static page from a ConfigMap, so you can update it without redeploying.

## Deploy

Edit avocado-app.yml and put your site at the bottom `Ingress.spec.rules[0].host`

```sh
kubectl create namespace avocado
kubectl apply -f avocado-app.yml -n avocado
```

Check the page with or visit the service

```sh
kubectl describe configmap/avocado-page -n avocado
```

## Update Config Map (aka Page Content)

A config map can be created from a file with `--from-file` option, but can not be updated.

The way to achieve this is by out-puting the yaml file of the _creation_ and apply it again to update.

```sh
kubectl create configmap avocado-page \
  --from-file index.html -o yaml --dry-run |
kubectl apply -f - -n avocado
```

Check the results with

```sh
kubectl describe configmap/avocado-page -n avocado
```
