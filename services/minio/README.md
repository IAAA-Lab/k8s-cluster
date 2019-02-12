# Minio Distributed

## Deploy

### Create Namespace

```sh
kubectl create namespace minio
```

### Create a Secret

First, we hardly recomend to disable history while doing this commands because you will have to type it in plain text.

**In bash:**

```sh
# Dissable history
set +o history
# Re-enable history
set -o history
```

**In zsh:**

Config that commands starting with a space will not be recorded to history file.

```sh
setopt HIST_IGNORE_SPACE
```

Now, let's create a secret so we can securely share our credentials across all replicas:

```sh
# Copy the keys to text plain files
echo -n "$YOUR_ACCES_KEY" > access_key
 echo -n "$YOUR_SECRET_KEY" > secret_key

# Create the secret
kubectl create secret generic credentials \
  --from-file access_key \
  --from-file secret_key \
  -n minio
```

**Note:** Do **not** open that files with a text editor, because most of them tend to append a new line character when saving

### Deploy de service

```sh
kubectl apply -f minio-distributed.yaml -n minio
```

### Expose the API

Edit the host in `ingress.yaml` and apply:

```sh
kubectl apply -f ingress.yaml -n minio
```
