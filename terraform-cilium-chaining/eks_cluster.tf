locals {
  cluster_name         = var.eks_cluster_name
  node_type_production = "m5.4xlarge"
  node_type_nonprod    = "m4.4xlarge"
}

data "aws_availability_zones" "available" {}

resource "aws_kms_key" "eks" {
  description             = "Secret Encryption Key for EKS"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_AWSAdministratorAccess_"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
}

# Ignore the tfsec check prohibiting security groups with 0.0.0.0/0 egress
#tfsec:ignore:aws-vpc-no-public-egress-sgr
#tfsec:ignore:aws-eks-no-public-cluster-access
#tfsec:ignore:aws-eks-no-public-cluster-access-to-cidr
module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "17.24.0"
  cluster_name                    = local.cluster_name
  cluster_version                 = var.eks_version
  subnets                         = module.vpc.private_subnets
  vpc_id                          = module.vpc.vpc_id
  enable_irsa                     = true
  cluster_endpoint_private_access = true
  #cluster_endpoint_public_access  = !var.vpn_only
  cluster_endpoint_public_access  = true
  map_roles                            = var.map_roles

  cluster_enabled_log_types = ["scheduler", "controllerManager", "authenticator", "audit", "api"]

  cluster_encryption_config = [
    {
      resources        = ["secrets"]
      provider_key_arn = aws_kms_key.eks.arn
    }
  ]

  worker_groups = [for i, s in module.vpc.private_subnets : {
    name                   = "${local.cluster_name}_worker-group-${i}"
    subnets                = [s]
    instance_type          = var.production ? local.node_type_production : local.node_type_nonprod
    asg_desired_capacity   = ceil(var.eks_desired_nodes / length(module.vpc.private_subnets))
    root_volume_type       = "gp3"
    root_volume_throughput = 125
    root_volume_size       = 80
    root_encrypted         = true
    tags = [
      {
        "key"                 = "k8s.io/cluster-autoscaler/enabled"
        "propagate_at_launch" = "false"
        "value"               = "true"
      },
      {
        "key"                 = "k8s.io/cluster-autoscaler/${local.cluster_name}"
        "propagate_at_launch" = "false"
        "value"               = "owned"
      }
    ]
  }]

  workers_additional_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_name" {
  value = local.cluster_name
}