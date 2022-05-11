variable "environment_name" {
  type = string
  default = "neil-1"
}
variable "production" {
  type    = bool
  default = false
}

variable "region" {
  default = "eu-west-2"
}

variable "eks_cluster_name" {
  type = string
  default = "neil-1"
}

variable "eks_desired_nodes" {
  type    = number
  default = 1
}

variable "dns_create_zone" {
  type    = bool
  default = true
}

variable "dns_domain_name" {
  type = string
  default = "dummy"
}

variable "dns_soa_email" {
  type = string
  default = "dummy"
}

variable "eks_version" {
  type    = string
  default = "1.21"
}

variable "vpn_only" {
  type        = bool
  default     = true
  description = "If true, only allow VPN-connected clients to connect to the CA"
}


variable "ca_arn" {
  description = "Certificate Authority's ARN. Needed until the Terraform provider can handle OCSP configuration of PCAs. See https://github.com/hashicorp/terraform-provider-aws/issues/21689"
  type        = string
  default = "arn:aws:acm-pca:eu-west-2:973101223973:certificate-authority/ff7438ce-b030-4501-87bc-2e308c01e7e0"
}


variable "cert_manager_version" {
  description = "Version for the cert manager"
  default     = "1.7.1"
}

variable "cluster_autoscaler_version" {
  description = "CA version"
  default     = "v1.21.2"
}

variable "ingress_version" {
  description = "Ingress Version"
  default     = "3.33.0"
}