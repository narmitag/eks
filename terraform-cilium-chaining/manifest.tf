data "aws_caller_identity" "current" {}

resource "local_file" "manifest_json" {
  count = 2
  content = templatefile("${path.module}/templates/manifest.json", {
    eks_version                = var.eks_version
    aws_region                 = var.region
    aws_account_id             = data.aws_caller_identity.current.account_id
    environment_name           = var.environment_name
    cert_manager_version       = var.cert_manager_version
    cluster_autoscaler_version = var.cluster_autoscaler_version
    ingress_version            = var.ingress_version
    }
  )
  filename = "manifest.json"
}
