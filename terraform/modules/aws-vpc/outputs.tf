output "vpc_id" {
  value = aws_vpc.main.id
}

output "owner_id" {
  value = aws_vpc.main.owner_id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "subnets" {
  value = var.subnets_cidrs
}

output "subnet_ids" {
  value = aws_subnet.subnets.*.id
}

output "route_table_id" {
  value = aws_route_table.subnets.id
}

output "default_security_group_id" {
  value = aws_vpc.main.default_security_group_id
}