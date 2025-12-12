#!/bin/bash

kubectl delete -f java-app.yaml
kubectl delete -f db-config.yaml
kubectl delete -f db-secret.yaml
