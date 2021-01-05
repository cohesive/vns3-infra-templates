output "network_id" {
  value = module.gcp_network.network_id
}

output "network_gateway" {
  value = module.gcp_network.network_gateway
}

output "subnet_cidrs" {
  value = module.gcp_network.subnet_cidrs
}

output "subnet_ids" {
  value = module.gcp_network.subnet_ids
}

output "region_zones" {
  value = module.gcp_network.region_zones
}

output "vns3_instance_ids" {
  value = module.gcp_vns3.vns3_instance_ids
}

output "vns3_primary_ips" {
  value = module.gcp_vns3.vns3_primary_ips
}

output "vns3_public_ips" {
  value = module.gcp_vns3.vns3_public_ips
}