variable "vpc_cidr" {
  default = "10.100.0.0/16"
}

variable "azs" {
  type = list(string)
  description = "the name of availability zones to use subnets"
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "public_subnets" {
  type = list(string)
  description = "the CIDR blocks to create public subnets"
  default = [ "10.100.10.0/24", "10.100.20.0/24" ]
}

variable "private_subnets" {
  type = list(string)
  description = "the CIDR blocks to create private subnets"
  default = [ "10.100.30.0/24", "10.100.40.0/24" ]
}

variable "instance_type_spot" {
  default = "t3a.medium"
  type    = string
}

variable "spot_bid_price" {
  default     = "0.0175"
  description = "How much you are willing to pay as an hourly rate for an EC2 instance, in USD"
}

variable "cluster_name" {
  default     = "ecs_terraform_ec2"
  type        = string
  description = "the name of an ECS cluster"
}

variable "min_spot" {
  default     = "1"
  description = "The minimum EC2 spot instances to be available"
}

variable "max_spot" {
  default     = "2"
  description = "The maximum EC2 spot instances that can be launched at peak time"
}