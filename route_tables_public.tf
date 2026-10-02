resource "aws_route_table" "devops_public" {
  vpc_id = aws_vpc.devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops.id
  }

  tags = {
    Name = "${var.project_name}-devops-public-rt"
  }
}

resource "aws_route_table" "app_public" {
  vpc_id = aws_vpc.app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app.id
  }

  tags = {
    Name = "${var.project_name}-app-public-rt"
  }
}

resource "aws_route_table_association" "devops_public" {
  count          = 2
  subnet_id      = aws_subnet.devops_public[count.index].id
  route_table_id = aws_route_table.devops_public.id
}

resource "aws_route_table_association" "app_web_public" {
  count          = 2
  subnet_id      = aws_subnet.app_web_public[count.index].id
  route_table_id = aws_route_table.app_public.id
}