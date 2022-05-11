# resource "helm_release" "cilium" {
#   name       = "cilium"
#   repository = "https://helm.cilium.io/"
#   chart      = "cilium"
#   version    = "1.9.13"
#   namespace  = "kube-system"

#   set {
#     name  = "eni"
#     value = "true"
#   }

#   set {
#     name  = "ipam.mode"
#     value = "eni"
#   }
#   set {
#     name  = "egressMasqueradeInterfaces"
#     value = "eth0"
#   }
#   set {
#     name  = "tunnel"
#     value = "disabled"
#   }
#   set {
#     name  = "nodeinit.enabled"
#     value = "true"
#   }
#   set {
#     name  = "hubble.listenAddress"
#     value = ":4244"
#   }
#   set {
#     name  = "hubble.relay.enabled"
#     value = "true"
#   }
#   set {
#     name  = "hubble.ui.enabled"
#     value = "true"
#   }


# }

resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.11.2"
  namespace  = "kube-system"

  set {
    name  = "cni.chainingMode"
    value = "aws-cni"
  }

  set {
    name  = "enableIPv4Masquerade"
    value = "false"
  }
  set {
    name  = "tunnel"
    value = "disabled"
  }
  set {
    name  = "hubble.listenAddress"
    value = ":4244"
  }
  set {
    name  = "hubble.relay.enabled"
    value = "true"
  }
  set {
    name  = "hubble.ui.enabled"
    value = "true"
  }


}
