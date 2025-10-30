variable "lb_name" {
  default = "production-lb-tf"
}

variable "load_balancer_type" {
  default = "application"
}

variable "lb_tag" {
  default = "production"
}

variable "http_port" {
  default = "80"
}

variable "http_protocol" {
  default = "HTTP"
}

variable "listener_default_action_forward" {
  default = "forward"
}

variable "listener_default_action_redirect" {
  default = "redirect"
}

variable "https_port" {
  default = "443"
}

variable "https_protocol" {
  default = "HTTPS"
}

variable "listener_status_code" {
  default = "HTTP_301"
}

variable "ssl_policy" {
  default = "ELBSecurityPolicy-2016-08"
}

variable "certificate_arn" {
  
}

variable "target_group_name" {
  default = "task-lb-tg"
}

variable "target_type" {
  default = "ip"
}

variable "vpc_id" {
  
}

variable "subnet_ids" {
  
}

variable "sg_id" {
  
}