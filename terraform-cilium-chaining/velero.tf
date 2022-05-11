module "velero" {
  source  = "DNXLabs/eks-velero/aws"
  version = "0.1.2"

  enabled = true

  cluster_name                     = module.eks.cluster_id
  cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
  aws_region                       = var.region
  create_bucket                    = true
  bucket_name                      = "pdp-cluster-velero-backup-${var.environment_name}"
}