<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.56.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.4.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.13.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.7.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert_manager_iam_oidc"></a> [cert\_manager\_iam\_oidc](#module\_cert\_manager\_iam\_oidc) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | ~> 4.0 |
| <a name="module_cloudwatch_logs"></a> [cloudwatch\_logs](#module\_cloudwatch\_logs) | git::https://github.com/DNXLabs/terraform-aws-eks-cloudwatch-logs.git | 0.1.4 |
| <a name="module_cloudwatch_metrics"></a> [cloudwatch\_metrics](#module\_cloudwatch\_metrics) | git::https://github.com/DNXLabs/terraform-aws-eks-cloudwatch-metrics.git | 0.1.1 |
| <a name="module_cluster_autoscaler_iam_oidc"></a> [cluster\_autoscaler\_iam\_oidc](#module\_cluster\_autoscaler\_iam\_oidc) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | ~> 4.0 |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 17.24.0 |
| <a name="module_paper_onboarding_iam_oidc"></a> [paper\_onboarding\_iam\_oidc](#module\_paper\_onboarding\_iam\_oidc) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 2.66.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.ca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_ec2_client_vpn_authorization_rule.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_endpoint.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_iam_policy.cert_manager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.paper_onboarding_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kms_key.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_route53_record.ingress_nginx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_security_group.allow_tls_from_eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_endpoint.api_gateway_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.ingress_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.secret_agent](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.cert_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [tls_cert_request.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_cert_request.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_locally_signed_cert.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_lb.ingress_nginx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |
| [kubectl_path_documents.secret_agent](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/path_documents) | data source |
| [kubernetes_service.ingress_nginx](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ca_arn"></a> [ca\_arn](#input\_ca\_arn) | Certificate Authority's ARN. Needed until the Terraform provider can handle OCSP configuration of PCAs. See https://github.com/hashicorp/terraform-provider-aws/issues/21689 | `string` | n/a | yes |
| <a name="input_dns_create_zone"></a> [dns\_create\_zone](#input\_dns\_create\_zone) | n/a | `bool` | `true` | no |
| <a name="input_dns_domain_name"></a> [dns\_domain\_name](#input\_dns\_domain\_name) | n/a | `string` | n/a | yes |
| <a name="input_dns_soa_email"></a> [dns\_soa\_email](#input\_dns\_soa\_email) | n/a | `string` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_eks_desired_nodes"></a> [eks\_desired\_nodes](#input\_eks\_desired\_nodes) | n/a | `number` | `1` | no |
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | n/a | `string` | `"1.21"` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | n/a | `string` | n/a | yes |
| <a name="input_production"></a> [production](#input\_production) | n/a | `bool` | `false` | no |
| <a name="input_rds_idm_instance_class"></a> [rds\_idm\_instance\_class](#input\_rds\_idm\_instance\_class) | EC2 Instance Class to use for RDS underpinning IDM database | `string` | n/a | yes |
| <a name="input_rds_idm_postgres_replicas"></a> [rds\_idm\_postgres\_replicas](#input\_rds\_idm\_postgres\_replicas) | Number of read-replicas to create in RDS. No effect if not in production mode. | `number` | `2` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certmanager_role_arn"></a> [certmanager\_role\_arn](#output\_certmanager\_role\_arn) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_vpc_endpoint_id"></a> [vpc\_endpoint\_id](#output\_vpc\_endpoint\_id) | n/a |
| <a name="output_vpn_client_cert"></a> [vpn\_client\_cert](#output\_vpn\_client\_cert) | n/a |
| <a name="output_vpn_client_key"></a> [vpn\_client\_key](#output\_vpn\_client\_key) | n/a |
<!-- END_TF_DOCS -->