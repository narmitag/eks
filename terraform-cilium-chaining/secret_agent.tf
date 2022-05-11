provider "kubectl" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}


data "kubectl_path_documents" "secret_agent" {
  pattern = "${path.module}/yaml/secret-agent.yaml"
}

resource "kubectl_manifest" "secret_agent" {
  count     = length(data.kubectl_path_documents.secret_agent.documents)
  yaml_body = element(data.kubectl_path_documents.secret_agent.documents, count.index)
}