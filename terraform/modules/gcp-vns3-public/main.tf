resource "google_compute_instance" "vns3" {
  count = var.vns3_count

  boot_disk {
    initialize_params {
      image = var.vns3_image_id
    }
  }

  machine_type    = var.vns3_instance_type
  name            = "${var.topology_name}-vns3-${count.index}"
  can_ip_forward  = true
  zone            = element(var.vns3_subnet_zones, count.index)

  network_interface {
    network    = var.network_id
    subnetwork = element(var.vns3_subnet_ids, count.index)

    access_config {
        network_tier = var.networking_tier
        nat_ip = element(google_compute_address.vns3_static_ip.*.address, count.index)
    }
  }

  tags = [
    "vns3"
  ]
}

resource "google_compute_address" "vns3_static_ip" {
  count = length(var.vns3_subnet_ids)
  name = "${var.topology_name}-vns3-${count.index}-public-ip"
  network_tier = var.networking_tier
  address_type = "EXTERNAL"
}


resource "google_compute_route" "to_internet" {
  count       = length(var.routeable_internet_cidrs)
  name        = "${var.topology_name}-internet-route"
  dest_range  = element(var.routeable_internet_cidrs, count.index)
  network     = var.network_id
  next_hop_gateway = "default-internet-gateway"
  priority    = 5000
}