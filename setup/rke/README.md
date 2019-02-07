# Kubernetes (RKE)

## Cleanup

Run the script on each server

```
wget -O - \
https://raw.githubusercontent.com/IAAA-Lab/k8s-cluster/master/setup/rke/cleanup.sh \
| sh
```

## Install Kubernetes Cluster

First, make sure you can `ssh` to the machines using your private key.

Download `rke`in yout workstation [from](https://github.com/rancher/rke/releases), move it to `/usr/bin/`, rename it as `rke` and `chmod +x` it. Try installation with `rke -v`.

Create a config file with `rke config --name config.yml` or edit the provided in this repo.

Run the command:

```
rke up
```

**Note:** RKE validation process doesn't allowe to use the same IP for more than one node so if the cluster is sitting behind a NAT, URL names will be mandatory. ej `machine-{n}.your.domain` and a wildcard DNS.

**Note2:** If something crashes during installation, clean before retrying with `rke remove`. Check logs accessing through `ssh` and `docker logs kubelet` for example.

The `rke up`command will create a `kube_config_cluster.yml`. This file is **SUPER IMPORTANT TO KEEP SECRET** because it hash API keys to manage the cluster.

Move this file to the correct kube dir:

```
mkdir -p ~/.kube
mv ./kube_config_cluster.yml ~/.kube/config
```

Now you can download `kubectl` followinf the [official instructions](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and try the access to the cluster by executing:

```
kubectl get all
```
