resource "aws_launch_template" "auto-scaling-group-app" {
  name = "auto-scaling-group-web"
  image_id = data.aws_ami.ecs-optimized.image_id
  instance_type = "t2.micro"
  key_name = "demo-key"

  user_data = base64encode(templatefile("userdata.sh.tpl", {
    ECS_CLUSTER = aws_ecs_cluster.prod_cluster.name
  }))

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile
  }

  network_interfaces {
    subnet_id = module.vpc.public_subnet_1_id
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

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs_instance_profile"
  role = aws_iam_role.ecs_instance_role.name

  # this is required to link so the ECS agent running on your EC2 Instance
  # can register with ECS cluster and manage containers
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
