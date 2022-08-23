output "vpc1_id" {
  value = module.aws_vpc1.vpc_id
}

output "vpc2_id" {
  value = module.aws_vpc2.vpc_id
}

output "vpc1_cidr" {
  value = module.aws_vpc1.vpc_cidr
}

output "vpc1_subnets" {
  value = var.vpc1_subnets
}

output "vpc2_cidr" {
  value = module.aws_vpc2.vpc_cidr
}

output "vpc2_subnets" {
  value = var.vpc2_subnets
}

output "vpc1_subnet_ids" {
  value = module.aws_vpc1.subnet_ids
}

output "vpc2_subnet_ids" {
  value = module.aws_vpc2.subnet_ids
}

output "vpc1_route_table_id" {
  value = module.aws_vpc1.route_table_id
}

output "vpc2_route_table_id" {
  value = module.aws_vpc2.route_table_id
}

output "vpc1_vns3_instance_ids" {
  value = module.vns3_vpc1.vns3_instance_ids
}

output "vpc2_vns3_instance_ids" {
  value = module.vns3_vpc2.vns3_instance_ids
}

output "vpc1_controller_public_ips" {
  value = module.vns3_vpc1.vns3_public_ips
}

output "vpc1_controller_dns_hostnames" {
  value = module.vns3_vpc1.vns3_hostnames
}

output "vpc1_controller_enis" {
  value = module.vns3_vpc1.vns3_network_interfaces
}

output "vpc2_controller_public_ips" {
  value = module.vns3_vpc2.vns3_public_ips
}

output "vpc2_controller_enis" {
  value = module.vns3_vpc2.vns3_network_interfaces
}

output "vpc2_controller_dns_hostnames" {
  value = module.vns3_vpc2.vns3_hostnames
}

output "vpc1_default_security_group_id" {
  value = module.aws_vpc1.default_security_group_id
}

output "vpc2_default_security_group_id" {
  value = module.aws_vpc2.default_security_group_id
}