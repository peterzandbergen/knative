#!/bin/bash

# Based on https://github.com/knative/docs/blob/master/install/Knative-with-GKE.md

# Default cluster settings
DEF_CLUSTER_NAME=knative
DEF_CLUSTER_ZONE=europe-west4-a

if [ -z ${CLUSTER_NAME} ] ; then
    CLUSTER_NAME=${DEF_CLUSTER_NAME}
fi

if [ -z ${CLUSTER_ZONE} ] ; then
    CLUSTER_ZONE=${DEF_CLUSTER_ZONE}
fi

echo $CLUSTER_NAME
echo $CLUSTER_ZONE

sleep 30

gcloud container clusters delete $CLUSTER_NAME --zone $CLUSTER_ZONE
