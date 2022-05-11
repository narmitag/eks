data "kubectl_path_documents" "storeageclass" {
  pattern = "${path.module}/yaml/storageclass.yaml"
}

resource "kubectl_manifest" "storeageclass" {
  count     = length(data.kubectl_path_documents.storeageclass.documents)
  yaml_body = element(data.kubectl_path_documents.storeageclass.documents, count.index)
}