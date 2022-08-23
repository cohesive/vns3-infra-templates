module "azure_vns3" {
  source              = "../../modules/azure-vns3-public"

  topology_name                  = var.topology_name
  vns3_resource_group_location   = module.azure_vnet.resource_group_location
  vns3_resource_group_name       = module.azure_vnet.resource_group_name
  route_table_name               = module.azure_vnet.route_table_name
  vns3_sku                       = "cohesive-vns3-4_8_x-byol"
  vns3_instance_password         = var.azure_instance_password
  vns3_vm_size                   = var.azure_vns3_vm_size
  subnet_ids                     = length(module.azure_vnet.subnet_ids) == 0 ? [] : slice(module.azure_vnet.subnet_ids, 0, 1)
  access_cidr                    = var.access_cidr
  common_tags                    = var.common_tags
}

module "aws_vns3" {
  source              = "../../modules/aws-vns3-public"

  topology_name       = var.topology_name
  vns3_version        = var.aws_vns3_version
  vns3_instance_type  = var.aws_vns3_instance_type
  vpc_id              = module.aws_vpc.vpc_id
  vpc_route_table_id  = module.aws_vpc.route_table_id
  access_cidr         = var.access_cidr
  client_cidrs        = [var.vpc_cidr]
  subnet_ids          = length(module.aws_vpc.subnet_ids) == 0 ? [] : slice(module.aws_vpc.subnet_ids, 0, 1)
  common_tags         = var.common_tags
}
