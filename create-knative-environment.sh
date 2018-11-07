#!/bin/bash

# Based on https://github.com/knative/docs/blob/master/install/Knative-with-GKE.md

# Default cluster settings
DEF_CLUSTER_NAME=knative
DEF_CLUSTER_ZONE=europe-west4-a

if [ -z ${CLUSTER_NAME} ] ; then
    CLUSTER_NAME=${DEV_CLUSTER_NAME}
fi

if [ -z ${CLUSTER_ZONE} ] ; then
    CLUSTER_ZONE=${DEV_CLUSTER_ZONE}
fi

# Set the default project
gcloud config set project gke-test-myhops

# Create cluster
gcloud container clusters create $CLUSTER_NAME \
    --zone=$CLUSTER_ZONE \
    --cluster-version=latest \
    --machine-type=n1-standard-4 \
    --enable-autoscaling --min-nodes=1 --max-nodes=10 \
    --enable-autorepair \
    --scopes=service-control,service-management,compute-rw,storage-ro,cloud-platform,logging-write,monitoring-write,pubsub,datastore \
    --num-nodes=3

# Grant cluster-admin to current user
kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin \
    --user=$(gcloud config get-value core/account)

# Intall istio
kubectl apply --filename https://raw.githubusercontent.com/knative/serving/v0.2.0/third_party/istio-1.0.2/istio.yaml

# Install knative serving and build
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.2.0/release.yaml

# Install kaniko build template
kubectl apply -f https://raw.githubusercontent.com/knative/build-templates/master/kaniko/kaniko.yaml

