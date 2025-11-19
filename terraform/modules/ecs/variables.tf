variable "ecs_cluster_name" {
    default = "production_ecs_cluster"
}

variable "task_definition_family" {
    default = "production_ecs_task_definition"
}

variable "container_definitions" {
    default = ([
    {
      name      = "my-app"
      image     = "058264103887.dkr.ecr.eu-west-2.amazonaws.com/production_repository"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

variable "ecs_service_name" {
    default = "production_ecs_service"
}

variable "ecs_service_desired_count" {
    default = 1
}

variable "ecs_service_launch_type" {
    default = "EC2"
}

variable "iam_role_name" {
    default = "task_execution_role"
}

variable "assume_role_policy" {
    default = ({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

variable "iam_role_policy_arn" {
    default = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "lb_target_group" {
  
}

variable "security_groups" {
  
}

variable "subnet_ids" {
  
}