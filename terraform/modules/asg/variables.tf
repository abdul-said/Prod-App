variable "user_data" {
  default = "#!/bin/bash\necho ECS_CLUSTER=production_ecs_cluster >> /etc/ecs/ecs.config"
  description = "user data to link instance to ecs cluster"
}

variable "key_name" {
  default = "VBox-2"
  description = "aws key name"
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
  description = "value is either true or false"
}

variable "data_ami_owners" {
  default = ["amazon"]
}

variable "data_ami_filter_name" {
  default = "name"
}

variable "data_ami_filter_value" {
  default = ["al2023-ami-ecs-hvm-*-x86_64"]
}

variable "instance_profile_name" {
  default = "ecs_instance_profile"
}

variable "iam_role_name" {
  default = "ecs_instance_role"
}

variable "iam_role_policy_arn" {
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
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
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

variable "subnet_id" {}

variable "security_groups" {}