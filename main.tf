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

