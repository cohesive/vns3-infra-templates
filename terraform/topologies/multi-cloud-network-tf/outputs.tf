output "aws_vpc_id" {
  value = module.aws_vpc.vpc_id
}

output "aws_vpc_cidr" {
  value = module.aws_vpc.vpc_cidr
}

output "aws_subnet_ids" {
  value = module.aws_vpc.subnet_ids
}

output "aws_route_table_id" {
  value = module.aws_vpc.route_table_id
}

output "aws_vns3_instance_ids" {
  value = module.aws_vns3.vns3_instance_ids
}

output "aws_default_security_group_id" {
  value = module.aws_vpc.default_security_group_id
}

output "azure_vnet_id" {
  value = module.azure_vnet.vnet_id
}

output "azure_vnet_cidr" {
  value = module.azure_vnet.vnet_cidr
}

output "azure_subnet_ids" {
  value = module.azure_vnet.subnet_ids
}

output "azure_route_table_id" {
  value = module.azure_vnet.route_table_id
}

output "azure_resource_group_name" {
  value = module.azure_vnet.resource_group_name
}

output "azure_resource_group_location" {
  value = module.azure_vnet.resource_group_location
}

output "aws_controller_ips" {
  value = module.aws_vns3.vns3_private_ips
}

output "aws_controller_public_ips" {
  value = module.aws_vns3.vns3_public_ips
}

output "azure_controller_ips" {
  value = module.azure_vns3.vns3_primary_ips
}

output "azure_controller_public_ips" {
  value = module.azure_vns3.vns3_public_ips
}

output "azure_controller_instance_names" {
  value = module.azure_vns3.vns3_instance_names
}