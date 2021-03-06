# In ROS

```bash
sudo ros service enable kernel-headers
sudo ros service up kernel-headers
```

If you want to mount aditional disks (ej, `/dev/sdb` and `/dev/sdc` ), test the mount:

```sh
sudo mkfs.ext4 /dev/sdb
sudo mount /dev/sdb1 /mnt/sdb
ls /mnt/sdb
```

Add it to the cloud config or via `ros config`:

```sh
sudo ros config set mounts '[["/dev/sdb1","/mnt/nfs","ext4",""],["/dev/sdc1","/mnt/minio","ext4",""]]'
```

# In rancher

Crate, if not, a `namespace` with called `nfs-volumes` and assign it to a the System Project.

```sh
kubectl create namespace nfs-volumes
```

The files have this namespace hardcoded for robustness reasons.

# Steps

```
kubectl apply -f nfs-server.yml
```

Get the service ip

```
kubectl describe service/nfs-server --namespace nfs-volumes | grep IP:
```

Edit the IP in `nfs-storage-class.yml`

```
kubectl apply -f nfs-storage-class.yml
```

# Check results

List Storage Classes that you have created

```
kubectl get storageclasses
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

## Cleaning Test

```
kubectl delete -f nfs-test.yml
```

NOTE: Removing a `Persistent Volume Claim` may take a while

# Test'

You can also login into your `storage-host-machine` and `ls /mnt/nfs`.
You will see a directory created by the `Storage Class`
