#!/bin/bash

output=$(helm repo list 2>&1 | grep traefik)

if [[ "$output" != *"traefik"* ]]
then
  helm repo add traefik https://traefik.github.io/charts
fi

helm install traefik traefik/traefik
