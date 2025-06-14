terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}
data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.2.0"

  name                 = "${local.app_name_prefix}-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

resource "aws_vpc_endpoint" "fargate_eks" {
  vpc_id       = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"
  service_name = "com.amazonaws.eu-central-1.eks"
  security_group_ids = [module.eks.cluster_security_group_id]
}

resource "aws_vpc_endpoint" "fargate_ecr_api" {
  vpc_id       = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"
  service_name = "com.amazonaws.eu-central-1.ecr.api"
  security_group_ids = [module.eks.cluster_security_group_id]
}

resource "aws_vpc_endpoint" "fargate_ecr_dkr" {
  vpc_id       = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"
  service_name = "com.amazonaws.eu-central-1.ecr.dkr"
  security_group_ids = [module.eks.cluster_security_group_id]
}

resource "aws_vpc_endpoint" "fargate_logs" {
  vpc_id       = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"
  service_name = "com.amazonaws.eu-central-1.logs"
  security_group_ids = [module.eks.cluster_security_group_id]
}

resource "aws_vpc_endpoint" "fargate_s3" {
  vpc_id       = module.vpc.vpc_id
  vpc_endpoint_type = "Gateway"
  service_name = "com.amazonaws.eu-central-1.s3"
  route_table_ids = [module.vpc.default_route_table_id]
}
