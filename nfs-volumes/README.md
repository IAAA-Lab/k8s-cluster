# In ROS

```bash
sudo ros service enable kernel-headers
sudo ros service up kernel-headers
```

# In rancher

Crate, if not, a `namespace` with called `nfs-volumes` and assign it to a the System Project.

The files have this namespace hardcoded for robustness reasons.

# Steps

```
kubectl apply -f nfs-server.yml
```

Get the service ip

```
kubectl describe service/nfs-server | grep IP:
```

Edit the IP in `nfs-storage-class.yml`

```
kubectl apply -f nfs-storage-class.yml
```

# Test

Run a test. It will create a `Persisten Volume Claim` and pick the default `Storage Class` for it.

```
kubectl apply -f nfs-test.yml
```

Check everything is working ok

```
kubectl get all | grep nfs-busybox
```

The pod should be running

# Test'

You can also login into your `storage-host-machine` and `ls /mnt/nfs`.
You will see a directory created by the `Storage Class`
