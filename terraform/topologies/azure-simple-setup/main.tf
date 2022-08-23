module "azure_vnet" {
  source              = "../../modules/azure-vnet"

  vnet_name           = "${var.topology_name}-${var.user}-vnet"
  vnet_cidr           = var.vnet_cidr
  vnet_region         = var.vnet_region
  subnets_private     = var.azure_subnets
  common_tags         = var.common_tags
  resource_group_name = "${var.azure_resource_group_name}-${var.user}"
}

module "azure_vns3" {
  source              = "../../modules/azure-vns3-public"

  topology_name                  = var.topology_name
  vns3_resource_group_location   = module.azure_vnet.resource_group_location
  vns3_resource_group_name       = module.azure_vnet.resource_group_name
  route_table_name               = module.azure_vnet.route_table_name
  vns3_sku                       = "cohesive-vns3-${replace(var.vns3_version, ".", "_")}_x-byol"
  vns3_instance_password         = var.azure_instance_password
  vns3_vm_size                   = var.azure_vns3_vm_size
  subnet_ids                     = length(module.azure_vnet.subnet_ids) == 0 ? [] : slice(module.azure_vnet.subnet_ids, 0, 2)
  access_cidr                    = var.access_cidr
  common_tags                    = var.common_tags
}