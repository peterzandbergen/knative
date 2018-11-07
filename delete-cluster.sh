#!/bin/bash

# Based on https://github.com/knative/docs/blob/master/install/Knative-with-GKE.md

# Create cluster in script
CLUSTER_NAME=knative
CLUSTER_ZONE=europe-west4-a

gcloud container clusters delete $CLUSTER_NAME --zone $CLUSTER_ZONE