provider "aws" {
  region = "eu-central-1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.29.0"
}

