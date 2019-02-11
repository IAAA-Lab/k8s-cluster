# Elasticsearch

## Deploy

```sh
kubectl create namespace elastic
```

Before adding the Ingress, you will need to create an Auth secret. Generate an `htpasswd` file with:

```sh
sudo apt-get install -y apache2-utils
htpasswd -c ./auth $USER
```

Create a secret based on that file:

```sh
kubectl create secret generic elastic-credentials --from-file auth -n elastic
```

Once the secrets has been created. Apply the rest of the manifest

```sh
kubectl apply -f elasticsearch.yaml -n elastic
```
