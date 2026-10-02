resource "aws_vpc" "devops" {
  cidr_block           = var.devops_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-devops-vpc-1"
    Environment = var.environment
  }
}

resource "aws_vpc" "app" {
  cidr_block           = var.app_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-aps1-vpc-01"
    Environment = var.environment
  }
}