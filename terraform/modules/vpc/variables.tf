variable "vpc_CIDR" {
  default = "10.0.0.0/16"
  description = "CIDR block for your vpc"
}

variable "public_subnet_1_CIDR" {
  default = "10.0.1.0/24"
  description = "CIDR block for your first subnet"
}

variable "public_subnet_2_CIDR" {
  default = "10.0.2.0/24"
  description = "CIDR block for your second subnet"
}

variable "public_subnet_3_CIDR" {
  default = "10.0.3.0/24"
  description = "CIDR block for your third subnet"
}

variable "route_table_CIDR" {
  default = "0.0.0.0/0"
  description = "default CIDR for route table"
}

variable "enable_dns_hostnames_true" {
  default = true
  description = "value can be true or false"
}

variable "enable_dns_support_true" {
  default = true
  description = "value can be true or false"
}

variable "map_public_ip_on_launch" {
  default = true
  description = "value can be true or false"
}

variable "vpc_name" {
  default = "production_vpc"
  description = "tags block name"
}

variable "IG_name" {
  default = "production_internet_gateway"
  description = "tags block name"
}

variable "public_subnet_1_name" {
  default = "public_subnet_1"
  description = "tags block name"
}

variable "public_subnet_2_name" {
  default = "public_subnet_2"
  description = "tags block name"
}

variable "public_subnet_3_name" {
  default = "public_subnet_3"
  description = "tags block name"
}

variable "route_table_name" {
  default = "production_route_table"
  description = "tags block name"
}