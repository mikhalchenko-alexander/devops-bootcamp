module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.29.0"

  cluster_version = "1.33"

  cluster_addons = {
    aws-ebs-csi-driver = {}
  }

  eks_managed_node_groups = {
    ng1 = {
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      node_group_name = "ng-1"
      instance_types = ["t3.small"]
      min_size        = 1
      max_size        = 3
      desired_size    = 3
    }
  }

  fargate_profiles = {
    default = {
      name = "fp-default"

      selectors = [
        {
          namespace = "java-app"
        }
      ]
    }
  }

  access_entries = {
    jenkins = {
      principal_arn = var.jenkins_user_arn
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
    alex = {
      principal_arn = var.alex_user_arn
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  cluster_name                   = local.cluster_name
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true
}

resource "aws_vpc_security_group_ingress_rule" "fargate_nodes_to_dns_tcp" {
  depends_on = [module.eks]
  security_group_id            = module.eks.node_security_group_id
  description                  = "Fargate nodes to cluster DNS TCP"
  ip_protocol                  = "tcp"
  from_port                    = 53
  to_port                      = 53
  referenced_security_group_id = data.aws_eks_cluster.cluster.vpc_config.cluster_security_group_id
}

resource "aws_vpc_security_group_ingress_rule" "fargate_nodes_to_dns_udp" {
  depends_on = [module.eks]
  security_group_id            = module.eks.node_security_group_id
  description                  = "Fargate nodes to cluster DNS UDP"
  ip_protocol                  = "udp"
  from_port                    = 53
  to_port                      = 53
  referenced_security_group_id = data.aws_eks_cluster.cluster.vpc_config.cluster_security_group_id
}

resource "aws_vpc_security_group_ingress_rule" "fargate_nodes_to_mysql_tcp" {
  depends_on = [module.eks]
  security_group_id            = module.eks.node_security_group_id
  description                  = "Fargate nodes to MySQL nodes"
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
  referenced_security_group_id = data.aws_eks_cluster.cluster.vpc_config.cluster_security_group_id
}
