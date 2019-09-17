variable "app_port" {
  default     = "80"
  type        = "string"
  description = "Application Port"
}

variable "app_count" {
  default     = "1"
  type        = "string"
  description = "Container number"
}

variable "app_image" {
  type        = "string"
  description = "Application Container"
}

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size
variable "fargate_cpu" {
  default     = "256"
  type        = "string"
  description = "Fargate CPU"
}

variable "fargate_memory" {
  default     = "512"
  type        = "string"
  description = "Fargate Memory"
}

variable "private_subnets" {
  type        = "list"
  description = "Private subnets"
}

variable "ecs_sg" {
  description = "ECS Security Group"
}

variable "alb_tg" {
  description = "Alb target group"
}

variable "name" {
  description = "Name"
}
