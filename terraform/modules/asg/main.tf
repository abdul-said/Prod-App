resource "aws_launch_template" "auto-scaling-group-app" {
  name = var.launch_template_name
  image_id = data.aws_ami.ecs-optimized.image_id
  instance_type = var.instance_type
  key_name = var.key_name 

  user_data = base64encode(var.user_data)

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  } 

  network_interfaces {
    subnet_id = var.subnet_id
    security_groups = var.security_groups
  }
}

resource "aws_autoscaling_group" "asg-1" {
  desired_capacity = var.asg_desired_capacity
  max_size = var.asg_max_size
  min_size = var.asg_min_size

  launch_template {
    id = aws_launch_template.auto-scaling-group-app.id
    version = var.launch_template_version
  }
}

data "aws_ami" "ecs-optimized" {
  most_recent      = var.data_ami_most_recent
  owners           = var.data_ami_owners

  filter {
    name   = var.data_ami_filter_name
    values = var.data_ami_filter_value
  }

}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.ecs_instance_role.name

  # this is required to link so the ECS agent running on your EC2 Instance
  # can register with ECS cluster and manage containers
}

resource "aws_iam_role" "ecs_instance_role" {
  name = var.iam_role_name
  assume_role_policy = jsonencode(var.assume_role_policy)
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = var.iam_role_policy_arn
}
