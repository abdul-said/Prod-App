resource "aws_launch_template" "auto-scaling-group-app" {
  name = "auto-scaling-group-web"
  image_id = data.aws_ami.ecs-optimized.image_id
  instance_type = "t2.micro"
  key_name = "demo-key"
  user_data = 

  iam_instance_profile {
    name = 
  }

  network_interfaces {
    subnet_id = module.vpc.public_subnet_id_1
    security_groups = [ aws_security_group.app_sg.id]
  }
}

resource "aws_autoscaling_group" "asg-1" {
  desired_capacity = 1
  max_size = 2
  min_size = 1

  launch_template {
    id = aws_launch_template.auto-scaling-group-app.id
    version = "$Latest"
  }
}

data "aws_ami" "ecs-optimized" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*"]
  }

}

resource "aws_iam_role" "ecs_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2008-10-17"
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
  role       = aws_iam_role.ecs_role.name
  policy_arn = "arn:aws:iam:aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}