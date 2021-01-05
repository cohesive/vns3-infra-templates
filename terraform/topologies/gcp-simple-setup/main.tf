module "gcp_network" {
  source              = "../../modules/gcp-vpc"

  vpc_name            = var.topology_name
  subnets_cidrs       = var.subnets_cidrs
  region              = var.region
}


module "gcp_vns3" {
  source              = "../../modules/gcp-vns3-public"

  topology_name             = var.topology_name
  region                    = var.region
  vns3_count                = 2
  vns3_subnet_ids           = module.gcp_network.subnet_ids
  vns3_subnet_zones         = module.gcp_network.region_zones
  vns3_instance_type        = var.vns3_instance_type
  vns3_image_id             = var.vns3_image_id
  networking_tier           = "STANDARD"
  routeable_internet_cidrs  = var.routeable_internet_cidrs
  network_id                = module.gcp_network.network_id
  admin_cidrs               = var.admin_cidrs
}
