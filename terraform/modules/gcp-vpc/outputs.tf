output "network_id" {
  value = google_compute_network.vpc_network.id
}

output "network_gateway" {
  value = google_compute_network.vpc_network.gateway_ipv4
}

output "subnet_cidrs" {
  value = var.subnets_cidrs
}

output "subnet_ids" {
  value = google_compute_subnetwork.vpc_subnetworks.*.id
}

output "region_zones" {
  value = data.google_compute_zones.available.names
}
