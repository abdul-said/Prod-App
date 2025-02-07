variable "vpc_CIDR" {
  description = "CIDR block for your vpc"
}

variable "public_subnet_1_CIDR" {
  description = "CIDR block for your first subnet"
}

variable "public_subnet_2_CIDR" {
  description = "CIDR block for your second subnet"
}

variable "public_subnet_3_CIDR" {
  description = "CIDR block for your third subnet"
}

variable "route_table_CIDR" {
  description = "default CIDR for route table"
}

variable "enable_dns_hostnames_true" {
  description = "value can be true or false"
}

variable "enable_dns_support_true" {
  description = "value can be true or false"
}

variable "map_public_ip_on_launch" {
  description = "value can be true or false"
}

variable "vpc_name" {
  description = "tags block name"
}

variable "IG_name" {
  description = "tags block name"
}

variable "public_subnet_1_name" {
  description = "tags block name"
}

variable "public_subnet_2_name" {
  description = "tags block name"
}

variable "public_subnet_3_name" {
  description = "tags block name"
}

variable "route_table_name" {
  description = "tags block name"
}