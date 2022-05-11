module "cloudwatch_logs" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-cloudwatch-logs.git?ref=0.1.4"

  enabled = true

  cluster_name                     = module.eks.cluster_id
  cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
  worker_iam_role_name             = module.eks.worker_iam_role_name
  region                           = var.region
}

module "cloudwatch_metrics" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-cloudwatch-metrics.git?ref=0.1.1"

  cluster_name                     = module.eks.cluster_id
  cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
  worker_iam_role_name             = module.eks.worker_iam_role_name
}