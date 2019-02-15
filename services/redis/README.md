# Redis

## Get Manifests

First, fetch sources using the scripts in [how to deploy Helm Charts without Tiller](/how-to/deploy-helm-without-tiller) tutorial.

```sh
helm fetch \
  --untar \
  --untardir ./charts \
  stable/redis
```

```sh
./make_manifests.sh redis \
  --name redis \
  --namespace redis \
  --set cluster.enabled=false \
  --set existingSecret=credentials
```

## Create namespace

```sh
kubectl create namespace redis
```

## Create the secret

```sh
echo -n "$PASSWORD" > redis-password
kubectl create secret generic credentials --from-file redis-password -n redis
```

## Deploy

```sh
kubectl apply -R -f ./manifests/redis -n redis
```

### Expose the port

We have found some issues when exposing Redis behind TLS temrination. Due to security reasons, we won't expose it under plain HTTP so the solution will temporary be port forward local host:

```sh
kubectl port-forward --address=localhost redis-master-0 6379:6379 -n redis
```

Now you can access to the pod through `localhost:6379`.
