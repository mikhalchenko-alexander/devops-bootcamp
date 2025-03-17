module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.29.0"

  cluster_version = "1.29"

  cluster_addons = {
    aws-ebs-csi-driver = {}
  }

  eks_managed_node_groups = {
    ng1 = {
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      node_group_name = "ng-1"
      instance_types = ["m5.large"]
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
