# Rancher Server v2

In this installation we are going to get rid of Tiller, the (they call mandatory) companion service of Helm that is no longer needed anymore thanks to the `helm template` command.

You can use the provided scripts or follow the detailed instructions down the file.

This opinionated installation will:

- Use LetsEncrypt instead of default self-signed certs

## Rancher Replicas

First, fetch sources using the scripts in [how to deploy Helm Charts without Tiller](/how-to/deploy-helm-without-tiller) tutorial.

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

## Racher config

Once rancher is up and running, you will be able to access it in `$RANCHER_URI`.

After setting the admin password and the service uri again, a banner will probably say that system is waiting for `service-uri`. To solve that, go to: `cluster: local > system > cattle-system > rancher`, click the options button and select `Redeploy`.
