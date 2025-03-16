provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region = "eu-central-1"
    bucket = "java-app-eks-terraform-state"
    key    = "global/s3/terraform.tfstate"

    dynamodb_table = "java-app-eks-terraform-locks"
    encrypt        = true
  }

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

locals {
  app_name_prefix = var.app_name_prefix
  cluster_name    = "${local.app_name_prefix}-${var.env_prefix}"
}
