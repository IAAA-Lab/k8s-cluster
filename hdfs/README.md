# Set up

## Git clone the charts

```
git clone https://github.com/apache-spark-on-k8s/kubernetes-HDFS.git ./repo
cp deploy.sh repo/deploy.sh
cd repo
```

## Set node labels

> from https://github.com/apache-spark-on-k8s/kubernetes-HDFS/blob/master/charts/README.md

For non-HA mode. First label the node that you want to be your `name-node`.

```
kubectl label nodes YOUR-CLUSTER-NODE hdfs-namenode-selector=hdfs-namenode-0
```

## Build the deps

```
helm repo add incubator \
  https://kubernetes-charts-incubator.storage.googleapis.com

helm dependency build charts/hdfs-k8s
```

## Run the Chart

```
./deploy.sh
```
