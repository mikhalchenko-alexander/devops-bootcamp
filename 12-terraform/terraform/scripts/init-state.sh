#!/bin/bash

BUCKET_NAME="java-app-eks-terraform-state"

if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
  echo "Bucket '$BUCKET_NAME' exists. Skipping Terraform commands."
else
  echo "Bucket '$BUCKET_NAME' does not exist. Running Terraform commands."
  terraform init && terraform apply --var-file=main.tfvars -auto-approve
fi
