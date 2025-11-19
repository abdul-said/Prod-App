variable "cidr_ipv4" {
  default = "0.0.0.0/0"
  description = "default 0.0.0.0/0 CIDR block for ipv4"
}

variable "http_port" {
  default = 80
  description = "value for http port"
}

variable "ssh_port" {
  default = 22
  description = "value for ssh port"
}

variable "ip_protocol_tcp" {
  default = "tcp"
  description = "value is tcp"
}

variable "cidr_ipv6" {
  default = "::/0"
  description = "default ::/0 CIDR block for ipv6"
}

variable "ip_protocol" {
  default = "-1"
  description = "value is -1"
}

variable "allow_tls" {
  default = "allow_tls"
  description = "value is allow tls"
}

variable "allow_tls_description" {
  default = "Allow TLS inbound traffic and all outbound traffic"
  description = "Allow TLS inbound traffic and all outbound traffic"
}

variable "vpc_id" {
  
}