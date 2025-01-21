terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}
module "vpc" {
}

module "acm" {
  
}

module "ecs" {
  
}

module "route53" {
  
}

module "alb" {
  
}

provider "aws" {
  region = "eu-west-2"
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_ecs_cluster" "foo" {
  name = "app-cluster"
}

resource "aws_ecs_task_definition" "service" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "my-app"
      image     = "058264103887.dkr.ecr.eu-west-2.amazonaws.com/project:latest"
      cpu       = 10
      memory    = 999
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  execution_role_arn = aws_iam_role.task_execution_role.arn
}

resource "aws_ecs_service" "app" {
  name            = "my-app"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 1
  launch_type     = "EC2"
}

resource "aws_launch_template" "auto-scaling-group-app" {
  name          = "auto-scaling-group-web"
  image_id      = data.aws_ami.ecs-optimized.image_id
  instance_type = "t2.micro"
  key_name      = "Demo Key"

  user_data     = base64encode(templatefile("userdata.sh.tpl", {
    ECS_CLUSTER = aws_ecs_cluster.foo.name
  }))

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  network_interfaces {
    subnet_id       = "subnet-0552c197da4a98bbe"
    security_groups = ["sg-090e639d13a884e4a"]
  }
}

resource "aws_autoscaling_group" "asg-1" {
  desired_capacity = 1
  max_size         = 2
  min_size         = 1

  launch_template {
    id      = aws_launch_template.auto-scaling-group-app.id
    version = "$Latest"
  }
}

data "aws_ami" "ecs-optimized" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*"]
  }

}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs_instance_profile"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "test_instance_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role" "task_execution_role" {
  name = "test_task_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
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

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy_attachment" "test-attach2" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
