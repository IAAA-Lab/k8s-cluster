# Rancher v2 Installation

## Cleanup

Run the script on each server

```
wget -O - \
https://raw.githubusercontent.com/IAAA-Lab/k8s-cluster/master/_setup/cleanup.sh \
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

## Install Rancher Server

In this installation we are going to get rid of Tiller, the (they call mandatory) companion service of Helm that is no longer needed anymore thanks to the `helm template` command.

You can use the provided scripts or follow the detailed instructions down the file.

This opinionated installation will:

- Use LetsEncrypt instead of default self-signed certs
-

### Cert Manager

```sh
kubectl create namespace cert-manager

kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

kubectl apply \
  -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/00-crds.yaml

kubectl apply \
  --validate=false \
  -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/cert-manager.yaml

# kubectl apply --validate=false -R -f ./manifests/cert-manager
```

**Note 1:** Update the branch of the static link with the current version you are using: `release-0.6`

**Note 2:** Visit [this PR](https://github.com/jetstack/cert-manager/pull/1223) to know why you have you put `--validate=false`.

To test the process:

```sh
# Create the test resources
kubectl apply -f test-resources.yaml

# Check the status of the newly created certificate
# You may need to wait a few seconds before cert-manager processes the
# certificate request
kubectl describe certificate -n cert-manager-test
...
Spec:
  Common Name:  example.com
  Issuer Ref:
    Name:       test-selfsigned
  Secret Name:  selfsigned-cert-tls
Status:
  Conditions:
    Last Transition Time:  2019-01-29T17:34:30Z
    Message:               Certificate is up to date and has not expired
    Reason:                Ready
    Status:                True
    Type:                  Ready
  Not After:               2019-04-29T17:34:29Z
Events:
  Type    Reason      Age   From          Message
  ----    ------      ----  ----          -------
  Normal  CertIssued  4s    cert-manager  Certificate issued successfully

# Clean up the test resources
kubectl delete -f test-resources.yaml
```

After that, you can see the new resources that has been created by querying: `kubectl api-resources | grep certmanager.k8s.io`

### Rancher Replicas

First, fetch sources

```sh
./fetch.sh https://releases.rancher.com/server-charts/stable rancher
```

Then, make the manifests with the proper options

```sh
./make_manifests.sh rancher \
  --name rancher \
  --namespace cattle-system \
  --set hostname=$RANCHER_URI \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.email=$MAIL \
  # --set letsEncrypt.environment=staging

```

**Note 1:** Keep `--set letsEncrypt.environment=staging` while trying deploys. Disable once you are sure the deploy works.
**Note 2:** Once you have changed deleted `staging`, you may delete the secret holding your cert to force Cert Manager to update it.

Staging environment certificates are signed by [another cert](https://letsencrypt.org/certs/fakelerootx1.pem) wich is not present in browsers. That's why you will se a certificate error when tying to access the service.

Having the manifests in `./manifest/rancher`, apply them:

```sh
kubectl create namespace cattle-system
kubectl apply -R --namespace cattle-system -f ./manifests/rancher
```

Check deploy with:

```sh
kubectl get all,issuers,certs,challenges,orders  --namespace cattle-system
```
