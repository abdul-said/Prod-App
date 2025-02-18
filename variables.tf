variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
    default = "production_vpc"
}

variable "internet_gateway_name" {
    default = "production_internet_gateway"
}

variable "route_table_cidr" {
    default = "0.0.0.0/0"
}

variable "route_table_name" {
    default = "production_route_table"
}

variable "public_subnet_1_cidr" {
    default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
    default = "10.0.2.0/24"
}

variable "public_subnet_3_cidr" {
    default = "10.0.3.0/24"
}

variable "public_subnet_1_name" {
    default = "public_subnet_1"
}

variable "public_subnet_2_name" {
    default = "public_subnet_2"
}

variable "public_subnet_3_name" {
    default = "public_subnet_3"
}

variable "map_public_ip_on_launch" {
    default = true
}

variable "enable_dns_hostnames_true" {
    default = true
}

variable "enable_dns_support_true" {
    default = true
}

variable "user_data" {
    type = string
    default = "#!/bin/bash\necho ECS_CLUSTER=production_ecs_cluster >> /etc/ecs/ecs.config"
}

variable "key_name" {
    default = "VBox-2"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "launch_template_name" {
    default = "production_auto_scaling_group"
}

variable "launch_template_version" {
    default = "$Latest"
}

variable "asg_desired_capacity" {
    default = 1
}

variable "asg_max_size" {
    default = 2
}

variable "asg_min_size" {
    default = 1
}

variable "data_ami_most_recent" {
    default = true
}

variable "data_ami_owners" {
    default = ["amazon"]
}

variable "data_ami_filter_name" {
    default = "name"
}

variable "data_ami_filter_value" {
    default = ["amzn2-ami-ecs-hvm-*"]
}

variable "instance_profile_name" {
    default = "ecs_instance_profile"
}

variable "iam_role_instance_role_name" {
    default = "ecs_instance_role"
}

variable "iam_role_instance_policy_arn" {
    default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

variable "assume_role_policy_instance_role" {
    default = ({
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
}

variable "ecs_cluster_name" {
    default = "production_ecs_cluster"
}

variable "task_definition_family" {
    default = "service"
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

variable "iam_role_execution_role_name" {
    default = "task_execution_role"
}

variable "assume_role_policy_execution_role" {
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

variable "iam_role_execution_policy_arn" {
    default = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "cidr_ipv4" {
    default = "0.0.0.0/0"
}

variable "http_port" {
    default = 80
}

variable "ssh_port" {
    default = 22
}

variable "ip_protocol_tcp" {
    default = "tcp"
}

variable "cidr_ipv6" {
    default = "::/0"
}

variable "ip_protocol" {
    default = "-1"
}

variable "allow_tls" {
    default = "allow_tls"
}

variable "allow_tls_description" {
    default = "Allow TLS inbound traffic and all outbound traffic"
}

variable "ecr_repo_name" {
    default = "production_repository"
}