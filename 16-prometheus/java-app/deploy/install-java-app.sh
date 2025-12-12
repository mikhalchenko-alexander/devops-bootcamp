#!/bin/bash

kubectl apply -f db-config.yaml
kubectl apply -f db-secret.yaml
kubectl apply -f java-app.yaml
