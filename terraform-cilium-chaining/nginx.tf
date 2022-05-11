resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"

  # values = [
  #   <<-EOF
  #   controller:
  #     service:
  #       annotations:
  #         service.beta.kubernetes.io/aws-load-balancer-type: nlb
  #   defaultBackend:
  #     enabled: true
  #     name: custom-default-backend
  #     image:
  #       repository: k8s.gcr.io/ingress-nginx
  #       image: ingress-nginx
  #       tag: 0.48.1
  #       pullpolicy: Always
  #   EOF
  # ]

  depends_on = [
    module.eks
  ]
}

data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = helm_release.ingress_nginx.metadata[0].namespace
  }
}

# data "aws_lb" "ingress_nginx" {
#   name = regex(
#     "(^[^-]+)",
#     data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].hostname
#   )[0]
# }

# resource "aws_route53_zone" "dns_zone" {
#   count = var.dns_create_zone ? 1 : 0
#   name  = var.dns_domain_name
# }

# resource "aws_route53_record" "ingress_nginx" {
#   count = var.dns_create_zone ? 1 : 0

#   zone_id = aws_route53_zone.dns_zone[0].zone_id
#   name    = "*"
#   type    = "A"

#   alias {
#     name                   = data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].hostname
#     zone_id                = data.aws_lb.ingress_nginx.zone_id
#     evaluate_target_health = false
#   }
# }