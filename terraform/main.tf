terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.83.1"
    }
  }
}
module "vpc" {
  source = "./modules/vpc"
  vpc_CIDR = var.vpc_cidr
  vpc_name = var.vpc_name
  IG_name = var.internet_gateway_name
  route_table_CIDR = var.route_table_cidr
  route_table_name = var.route_table_name
  public_subnet_1_CIDR = var.public_subnet_1_cidr
  public_subnet_1_name = var.public_subnet_1_name
  public_subnet_2_CIDR =  var.public_subnet_2_cidr
  public_subnet_2_name =  var.public_subnet_2_name
  public_subnet_3_CIDR = var.public_subnet_3_cidr
  public_subnet_3_name = var.public_subnet_3_name
  map_public_ip_on_launch = var.map_public_ip_on_launch
  enable_dns_hostnames_true = var.enable_dns_hostnames_true
  enable_dns_support_true = var.enable_dns_support_true
}

module "asg" {
  source = "./modules/asg"
  key_name = var.key_name
  user_data = var.user_data
  launch_template_name = var.launch_template_name
  launch_template_version = var.launch_template_version
  instance_profile_name = var.instance_profile_name
  instance_type = var.instance_type
  asg_desired_capacity = var.asg_desired_capacity
  asg_max_size = var.asg_max_size
  asg_min_size = var.asg_min_size
  assume_role_policy = var.assume_role_policy_instance_role
  iam_role_name = var.iam_role_instance_role_name
  iam_role_policy_arn = var.iam_role_instance_policy_arn
  data_ami_most_recent = var.data_ami_most_recent
  data_ami_owners = var.data_ami_owners
  data_ami_filter_name = var.data_ami_filter_name
  data_ami_filter_value = var.data_ami_filter_value
  security_groups = module.sg.security_group_id
  subnet_id = module.vpc.public_subnet_1_id
}

module "ecs" {
  source = "./modules/ecs"
  ecs_cluster_name = var.ecs_cluster_name
  ecs_service_desired_count = var.ecs_service_desired_count
  ecs_service_launch_type = var.ecs_service_launch_type
  ecs_service_name = var.ecs_service_name
  container_definitions = var.container_definitions
  iam_role_name = var.iam_role_execution_role_name
  iam_role_policy_arn = var.iam_role_execution_policy_arn
  task_definition_family = var.task_definition_family
  assume_role_policy = var.assume_role_policy_execution_role
  security_groups = module.sg.security_group_id
  lb_target_group = module.elb.target_group_arn
  subnet_ids = module.vpc.subnet_ids
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  cidr_ipv4 = var.cidr_ipv4
  cidr_ipv6 = var.cidr_ipv6
  ip_protocol = var.ip_protocol
  ip_protocol_tcp = var.ip_protocol_tcp
  http_port = var.http_port
  ssh_port = var.ssh_port
  allow_tls = var.allow_tls
  allow_tls_description = var.allow_tls_description
}

module "ecr" {
  source = "./modules/ecr"
  ecr_repo_name = var.ecr_repo_name
}

module "acm" {
  source = "./modules/acm"
  zone_id = module.route53.zone_id
  
}

module "elb" {
  source = "./modules/elb"
  vpc_id = module.vpc.vpc_id
  certificate_arn = module.acm.certificate_arn
  sg_id = module.sg.security_group_id
  subnet_ids = module.vpc.subnet_ids
}

module "route53" {
  source = "./modules/route53"
  lb_dns_name = module.elb.alb_dns_name
  lb_zone_id = module.elb.alb_zone_id
}


