resource "aws_vpc_peering_connection" "devops_to_app" {
  vpc_id      = aws_vpc.devops.id
  peer_vpc_id = aws_vpc.app.id
  auto_accept = true

  tags = {
    Name = "${var.project_name}-vpc-peering"
  }
}

resource "aws_route" "devops_to_app" {
  route_table_id            = aws_route_table.devops_public.id
  destination_cidr_block    = var.app_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.devops_to_app.id
}

resource "aws_route" "app_to_devops" {
  route_table_id            = aws_route_table.app_public.id
  destination_cidr_block    = var.devops_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.devops_to_app.id
}