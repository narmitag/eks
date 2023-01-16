locals {
  task_def_name = "nginx"
  service_name = "service1"
}

data "aws_caller_identity" "current" {}

resource "aws_ecs_task_definition" "task_definition" {
  family             = local.task_def_name
  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"
  memory             = 1024
  cpu                = 512
  container_definitions = jsonencode([
    {
      name      = local.task_def_name
      image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${local.aws_region}.amazonaws.com/${local.task_def_name}:latest"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  tags = merge(
    local.common_tags,
    {
      Name = local.task_def_name
    }
  )
}

resource "aws_ecs_service" "nginx" {
  name            = local.service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 2
}