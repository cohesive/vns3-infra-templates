resource "google_compute_subnetwork" "vpc_subnetworks" {
  count             = length(var.subnets_cidrs)
  name              = format("%s-subnet-%d", var.vpc_name, count.index)
  ip_cidr_range     = element(var.subnets_cidrs, count.index)
  region            = var.region
  network           = google_compute_network.vpc_network.id
}

resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
  auto_create_subnetworks = false
}

data "google_compute_zones" "available" {
  region = var.region
}