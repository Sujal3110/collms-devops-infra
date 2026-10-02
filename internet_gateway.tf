resource "aws_internet_gateway" "devops" {
  vpc_id = aws_vpc.devops.id

  tags = {
    Name = "${var.project_name}-devops-igw"
  }
}

resource "aws_internet_gateway" "app" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "${var.project_name}-igw-1"
  }
}