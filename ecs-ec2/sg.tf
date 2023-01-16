module "ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "ec2_sg"
  vpc_id = module.ecs_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80 #80
      to_port     = 80 #80
      protocol    = "tcp"
      description = "http port"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22 #22
      to_port     = 22 #22
      protocol    = "tcp"
      description = "ssh port"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
    cidr_blocks = "0.0.0.0/0" }
  ]
}