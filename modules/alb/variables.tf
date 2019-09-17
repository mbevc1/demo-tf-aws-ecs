variable "vpc_main_id" {
  type        = "string"
  description = "VPC id"
}

variable "public_subnets" {
  type        = "list"
  description = "Public Subnets"
}

variable "security_group" {
  description = "LB Security group"
}

variable "name" {
  description = "Name"
}
