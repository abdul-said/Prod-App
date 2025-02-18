variable "cidr_ipv4" {
  description = "default 0.0.0.0/0 CIDR block for ipv4"
}

variable "http_port" {
  description = "value for http port"
}

variable "ssh_port" {
  description = "value for ssh port"
}

variable "ip_protocol_tcp" {
  description = "value is tcp"
}

variable "cidr_ipv6" {
  description = "default ::/0 CIDR block for ipv6"
}

variable "ip_protocol" {
  description = "value is -1"
}

variable "allow_tls" {
  description = "value is allow tls"
}

variable "allow_tls_description" {
  description = "Allow TLS inbound traffic and all outbound traffic"
}