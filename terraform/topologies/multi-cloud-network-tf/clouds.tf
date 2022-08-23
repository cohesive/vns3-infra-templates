module "azure_vnet" {
  source              = "../../modules/azure-vnet"

  vnet_name           = var.vnet_name
  vnet_cidr           = var.vnet_cidr
  vnet_region         = var.vnet_region
  subnets_private     = var.azure_subnets
  common_tags         = var.common_tags
  resource_group_name = var.azure_resource_group_name
}


module "aws_vpc" {
  source              = "../../modules/aws-vpc"

  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  aws_region          = var.aws_region
  subnets_cidrs       = var.aws_subnets
  region_azs          = var.aws_region_azs
  common_tags         = var.common_tags
}
