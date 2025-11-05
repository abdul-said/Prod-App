
resource "aws_security_group" "app_sg" {
  name        = var.allow_tls
  description = var.allow_tls_description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.allow_tls 
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv4         = var.cidr_ipv4
  from_port         = var.http_port
  ip_protocol       = var.ip_protocol_tcp
  to_port           = var.http_port
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv6" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv6         = var.cidr_ipv6
  from_port         = var.http_port
  ip_protocol       = var.ip_protocol_tcp
  to_port           = var.http_port
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv4         = var.cidr_ipv4
  from_port         = 443
  ip_protocol       = var.ip_protocol_tcp
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv6" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv6         = var.cidr_ipv6
  from_port         = 443
  ip_protocol       = var.ip_protocol_tcp
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv4         = var.cidr_ipv4
  from_port         = var.ssh_port
  ip_protocol       = var.ip_protocol_tcp
  to_port           = var.ssh_port
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv6" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv6         = var.cidr_ipv6
  from_port         = var.ssh_port
  ip_protocol       = var.ip_protocol_tcp
  to_port           = var.ssh_port

}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv4         = var.cidr_ipv4
  ip_protocol       = var.ip_protocol # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv6         = var.cidr_ipv6
  ip_protocol       = var.ip_protocol  # semantically equivalent to all ports
}