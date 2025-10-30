resource "aws_lb" "production" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = var.sg_id  # fix this
  subnets            = var.subnet_ids # fix this

  tags = {
    Environment = var.lb_tag 
  }
}

resource "aws_lb_listener" "HTTP" {
  load_balancer_arn = aws_lb.production.arn
  port              = var.http_port
  protocol          = var.http_protocol

  default_action {
    type = var.listener_default_action_redirect

    redirect {
      port        = var.https_port
      protocol    = var.https_protocol
      status_code = var.listener_status_code
    }
  }
}

resource "aws_lb_listener" "HTTPS" {
  load_balancer_arn = aws_lb.production.arn
  port              = var.https_port
  protocol          = var.https_protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn # grab this from acm

  default_action {
    type             = var.listener_default_action_forward
    target_group_arn = aws_lb_target_group.production.arn
  }
}

resource "aws_lb_target_group" "production" {
  name     = var.target_group_name
  port     = var.http_port
  protocol = var.http_protocol
  target_type = var.target_type
  vpc_id   = var.vpc_id
}
