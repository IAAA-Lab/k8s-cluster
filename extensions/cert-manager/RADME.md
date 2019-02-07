# Cert Manager

## Install the extension Cert Manager

```sh
kubectl create namespace cert-manager

kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

kubectl apply \
  -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/00-crds.yaml

kubectl apply \
  --validate=false \
  -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/cert-manager.yaml
```

**Note 1:** Update the branch of the static link with the current version you are using: `release-0.6`

**Note 2:** Visit [this PR](https://github.com/jetstack/cert-manager/pull/1223) to know why you have you put `--validate=false`.

You can check that the resources has been created with: `kubectl api-resources | grep certmanager`

## Install a global Cluster Issuer

Certificates have to be requested by an Issuer. Normal Issuers are namespaced so you have to create one per namespace. That's why creating a ClusterIssuer is a good option if you want to share it across namespaces.

Our ClusterIssuer will use Let's Encrypt and a pre-configured mail.

```sh
kubectl apply -f issuer.yaml
```

Check it with: `kubectl get clusterissuers`

## Test it

To test the process:

```sh
# Create the test resources
kubectl apply -f test-resources.yaml

# Check the status of the newly created certificate
# You may need to wait a few seconds before cert-manager processes the
# certificate request
kubectl describe certificate -n cert-manager-test
...
Events:
  Type    Reason      Age   From          Message
  ----    ------      ----  ----          -------
  Normal  Generated      72s   cert-manager  Generated new private key
  Normal  OrderCreated   72s   cert-manager  Created Order resource "test-tls-401483257"
  Normal  OrderComplete  68s   cert-manager  Order "test-tls-401483257" completed successfully
  Normal  CertIssued     68s   cert-manager  Certificate issued successfully
```

The important part is `Generated new private key`. You can also check that, if you access to the `$HOST` you defined, it will redirect you to an `https` conecction with a valid certificate (ignore de `5XX Error`, that's beacuse you don't have any valid Service)

```sh
# Clean up the test resources
kubectl delete -f test-resources.yaml
```
