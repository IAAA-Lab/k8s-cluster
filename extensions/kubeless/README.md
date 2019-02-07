# Kubeless

## Installation

### CLI

Download the `cli` from its [oficial repo](https://github.com/kubeless/kubeless/releases), place it in your path (ej. `/usr/bin/`), and give it execution permissions (`chmod u+x kubeless`) . Test the installation with: `kubeless version`.

### Kubernetes Extension

Now, install the extension in your cluster:

```sh
kubectl create ns kubeless
kubectl create -f https://github.com/kubeless/kubeless/releases/download/v1.0.2/kubeless-v1.0.2.yaml
```

Test the deploy with: `kubeless get-server-config`. This will show you the supported runtimes (aka languajes).

### GUI

The GUI manifest [provided by Kubeless](https://raw.githubusercontent.com/kubeless/kubeless-ui/master/k8s.yaml) uses a Service with a `NodePort`. We prefer Service + Ingress options so we are going to patch this. First, apply the original manifest:

```sh
kubectl create -f https://raw.githubusercontent.com/kubeless/kubeless-ui/master/k8s.yaml
```

Now, you have two options:

- Edit the original resource with `vi` editor using:
  - `kubectl edit service/ui -n kubeless`
- Delete the service and create a new one:
  - `kubectl delete service/ui -n kubeless`
  - `kubectl create -f service.yaml -n kubeless`

Before adding the Ingress, you will need to create an Auth secret. Generate an `htpasswd` file with:

```sh
sudo apt-get install -y apache2-utils
htpasswd -c ./auth $USER
```

Create a secret based on that file:

```sh
kubectl create secret generic ui-credentials --from-file auth -n kubeless
```

Finally, edit the `host` value in the Ingress provided in this directory and apply it:

```sh
kubectl apply -f ingress.yaml -n kubeless
```

## Uninstall

```sh
kubectl delete -f https://github.com/kubeless/kubeless/releases/download/v1.0.2/kubeless-v1.0.2.yaml

```
