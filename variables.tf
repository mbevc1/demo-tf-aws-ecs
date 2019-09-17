variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS Region"
}

variable "profile" {
  type        = string
  default     = "test"
  description = "AWS Credentials Profile"
}

variable "name" {
  type        = string
  default     = "my-app"
  description = "Application name"
}

variable "image" {
  type        = string
  default     = "nginx:latest"
  description = "Application container"
}
