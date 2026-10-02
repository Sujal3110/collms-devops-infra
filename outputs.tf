output "devops_vpc_id" {
  value = aws_vpc.devops.id
}

output "app_vpc_id" {
  value = aws_vpc.app.id
}

output "devops_public_subnet_ids" {
  value = aws_subnet.devops_public[*].id
}

output "app_web_public_subnet_ids" {
  value = aws_subnet.app_web_public[*].id
}