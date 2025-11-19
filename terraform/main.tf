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
}

module "asg" {
  source = "./modules/asg"
  security_groups = module.sg.security_group_id
  subnet_id = module.vpc.public_subnet_1_id
}

module "ecs" {
  source = "./modules/ecs"
  security_groups = module.sg.security_group_id
  lb_target_group = module.elb.target_group_arn
  subnet_ids = module.vpc.subnet_ids
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ecr" {
  source = "./modules/ecr"
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


