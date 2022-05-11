resource "aws_security_group" "allow_tls_from_eks" {
  name        = "allow_tls_from_eks"
  description = "Allow TLS inbound from EKS worker nodes"
  vpc_id      = module.vpc.vpc_id

  ingress = [
    {
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      security_groups  = [module.eks.worker_security_group_id]
      description      = "Allow TLS from worker nodes"
      ipv6_cidr_blocks = []
      prefix_list_ids  = null
      cidr_blocks      = []
      self             = null
    }
  ]

  #   egress = [
  #     {
  #       from_port        = 0
  #       to_port          = 0
  #       protocol         = "-1"
  #       cidr_blocks      = ["0.0.0.0/0"]
  #       description      = "Allow all outbound"
  #       ipv6_cidr_blocks = []
  #       prefix_list_ids  = null
  #       security_groups  = []
  #       self             = null
  #     }
  #   ]
}

resource "aws_vpc_endpoint" "api_gateway_endpoint" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.execute-api"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.allow_tls_from_eks.id,
  ]

  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
}

output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.api_gateway_endpoint.id
}