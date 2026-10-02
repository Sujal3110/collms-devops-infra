# DevOps VPC - Public Subnets (2 AZ)
resource "aws_subnet" "devops_public" {
  count                   = 2
  vpc_id                  = aws_vpc.devops.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-devops-pub-sub-${count.index + 1}"
  }
}

# DevOps VPC - Private Subnets (2 AZ)
resource "aws_subnet" "devops_private" {
  count             = 2
  vpc_id            = aws_vpc.devops.id
  cidr_block        = "10.0.${count.index + 10}.0/24"
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.project_name}-devops-priv-sub-${count.index + 1}"
  }
}

# App VPC - Web tier Public Subnets (2 AZ)
resource "aws_subnet" "app_web_public" {
  count                   = 2
  vpc_id                  = aws_vpc.app.id
  cidr_block              = "10.1.${count.index + 1}.0/24"
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-web-eg-${count.index == 0 ? "ap1a" : "ap1b"}-sub-01"
  }
}

# App VPC - App tier Private Subnets (2 AZ) — for EKS nodes
resource "aws_subnet" "app_private" {
  count             = 2
  vpc_id            = aws_vpc.app.id
  cidr_block        = "10.1.${count.index + 10}.0/24"
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.project_name}-app-priv-${count.index == 0 ? "ap1a" : "ap1b"}-sub-01"
  }
}

# App VPC - DB tier Private Subnets (2 AZ) — for PostgreSQL
resource "aws_subnet" "app_db_private" {
  count             = 2
  vpc_id            = aws_vpc.app.id
  cidr_block        = "10.1.${count.index + 20}.0/24"
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.project_name}-db-priv-${count.index == 0 ? "ap1a" : "ap1b"}-sub-01"
  }
}