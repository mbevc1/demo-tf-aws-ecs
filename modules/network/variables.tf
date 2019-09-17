variable "az_count" {
  default     = 2
  type        = "string"
  description = "Number of AZ counts to use"
}

variable "cidr_block" {
  default     = "172.16.0.0/16"
  type        = "string"
  description = "Base CIDR"
}
