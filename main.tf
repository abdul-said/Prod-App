terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}
module "vpc" {
  source = "./modules/vpc"
}

module "asg" {
  source = "./modules/asg"
}

module "ecs" {
  source = "./modules/ecs"
}

module "route53" {
  source = "./modules/route53"
}

module "acm" {
  source = "./modules/acm"
}

module "sg" {
  source = "./modules/sg"
}


