# Hands on

## Rancher v2

### Installation

Intall with:

```
docker run -d --restart=unless-stopped \
  -p 8888:443 \
  -v /mnt/rancher:/var/lib/rancher \
  --name rancher-server \
  rancher/rancher
```

Check progress with:

```
docker logs rancher-server -f
```

### Cleanup

```
#!/bin/sh
docker rm -f $(docker ps -qa)
docker volume rm $(docker volume ls -q)
cleanupdirs="/mnt/rancher /var/lib/etcd /etc/kubernetes /etc/cni /opt/cni /var/lib/cni /var/run/calico"
for dir in $cleanupdirs; do
  echo "Removing $dir"
  sudo rm -rf $dir
done
```

### Add Helm support

```
kubectl -n kube-system create serviceaccount tiller

kubectl create clusterrolebinding tiller \
  --clusterrole cluster-admin \
  --serviceaccount=kube-system:tiller

helm init --service-account tiller
```
