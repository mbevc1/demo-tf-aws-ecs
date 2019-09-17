variable "app_port" {
  default     = "80"
  type        = "string"
  description = "Application Port"
}

variable "vpc_main_id" {
  type        = "string"
  description = "VPC id"
}

variable "name" {
  type        = "string"
  description = "App name"
}
