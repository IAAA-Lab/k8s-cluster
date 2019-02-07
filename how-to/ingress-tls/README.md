# Config TLS

In order to automatically get a Certificate, we can exploit the `nginx-shim` functionality by giving an specific annotation to the Ingress and configuring a `tls` secret:

```yml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    certmanager.k8s.io/cluster-issuer: global-issuer
  ...
spec:
  tls:
    - hosts:
        - $HOST
      secretName: $SECRET_NAME
```

This annotation will tell `cart-manager` that this Ingress wants a `tls` secret called `$SECRET_NAME` issued for `$HOST` by `global-issuer` Cluster Issuer.
