resource "aws_route_table" "app_private" {
  vpc_id = aws_vpc.app.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.app.id
  }

  tags = {
    Name = "${var.project_name}-app-private-rt"
  }
}

resource "aws_route_table_association" "app_private" {
  count          = 2
  subnet_id      = aws_subnet.app_private[count.index].id
  route_table_id = aws_route_table.app_private.id
}

resource "aws_route_table_association" "app_db_private" {
  count          = 2
  subnet_id      = aws_subnet.app_db_private[count.index].id
  route_table_id = aws_route_table.app_private.id
}