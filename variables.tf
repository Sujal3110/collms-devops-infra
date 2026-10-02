variable "aws_region" {
  description = "AWS region where resources are created"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Naming prefix for all resources"
  type        = string
  default     = "collms"
}

variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
  default     = "dev"
}

variable "azs" {
  description = "Availability zones for high availability"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "devops_vpc_cidr" {
  description = "IP range for DevOps VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "app_vpc_cidr" {
  description = "IP range for App VPC"
  type        = string
  default     = "10.1.0.0/16"
}
variable "my_ip" {
  description = "Your public IPv4 address for SSH/admin access, in CIDR format"
  type        = string
  default     = "47.11.21.106/32"
}