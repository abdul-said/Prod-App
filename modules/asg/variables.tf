variable "user_data" {
  description = "user data to link instance to ecs cluster"
}

variable "key_name" {
  description = "aws key name"
}

variable "instance_type" {}

variable "launch_template_name" {}

variable "launch_template_version" {}

variable "asg_desired_capacity" {}

variable "asg_max_size" {}

variable "asg_min_size" {}

variable "data_ami_most_recent" {
  description = "value is either true or false"
}

variable "data_ami_owners" {}

variable "data_ami_filter_name" {}

variable "data_ami_filter_value" {}

variable "instance_profile_name" {}

variable "iam_role_name" {}

variable "iam_role_policy_arn" {}

variable "assume_role_policy" {}

variable "subnet_id" {}

variable "security_groups" {}