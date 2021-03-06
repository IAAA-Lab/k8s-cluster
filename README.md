# Hands on K8S: A container cluster on premise

This repo describes the processes and decisions made in our own self hosted cluster. It may not be useful to you. We are not responsible of the maintenance and correctness of this instructions. Follow at your own risk.

## Index

1. [Set up](/setup): The first steps into this project
   1. [Kubernetes (RKE)](/setup/rke): Config and deploy a ready to use cluster with `rke` tool.
1. [Extensions](/extensions): Add capabilities to the cluster
   1. [Cert Manager](/extensions/cert-manager): Add a controller to automatically manage certificates (using `custom-resource`)
   1. [Rancher Server](/extensions/rancher-server):
   1. [Kubeless](/extensions/kubeless): Add serverless functions
   1. [NFS Volumes](/extensions/nfs-volumes): Add distributed persistent volumes capabilities
1. [How To](/how-to): Ready to deploy manifests of our most used services
   1. [TLS Services](/how-to/tls-services): Config a service's ingress to use HTTPS
   1. [Deploy Helm Charts without Tiller](/how-to/deploy-helm-without-tiller): Config a service's ingress to use HTTPS
1. [Services](/services): Ready to deploy manifests of our most used services
   1. [Avocado](/services/avocado): Simple Proof of Concept App
   1. [Elasticsearch](/services/elasticsearch): An scaling elasticsearch cluster
   1. [Minio](/services/minio): An S3 open source clone
   1. [Redis](/services/redis): A Key/Value store service
