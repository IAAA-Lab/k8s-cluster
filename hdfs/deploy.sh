#!/bin/sh
# helm install -n hdfs --namespace hdfs \
#   --set "tags.ha"="false" \
#   --set "tags.simple"="true" \
#   --set "global.namenodeHAEnabled"="false" \
#   --set "hdfs-simple-namenode-k8s.nodeSelector.hdfs-namenode-selector"="hdfs-namenode-0" \
#   --set "hdfs-namenode-k8s.persistence.storageClass"="nfs-archive" \
#   --set "hdfs-namenode-k8s.persistence.size"="100Gi" \
#   --set "global.dataNodeHostPath"="{/mnt/hdfs/}" \
#   charts/hdfs-k8s

  helm install -n hdfs --namespace hdfs \
    --set "hdfs-namenode-k8s.persistence.storageClass"="nfs-archive" \
    --set "hdfs-namenode-k8s.persistence.size"="100Gi" \
    --set "global.dataNodeHostPath"="{/mnt/hdfs/}" \
    charts/hdfs-k8s
