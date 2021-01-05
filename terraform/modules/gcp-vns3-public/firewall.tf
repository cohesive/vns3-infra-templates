resource "google_compute_firewall" "internal_vns3_app_access" {
  name          = "${var.topology_name}-vns3-app-access"
  description   = "API access between VNS3 controllers"
  network       = var.network_id
  direction     = "INGRESS"

  allow {
    protocol = "tcp"
    ports = ["8000"]
  }

  source_tags = ["vns3"]
  target_tags = ["vns3"]
}

resource "google_compute_firewall" "internal_vns3_peering_access" {
  name          = "${var.topology_name}-vns3-peering"
  description   = "Peering traffic between VNS3 Controllers"
  network       = var.network_id
  direction     = "INGRESS"

  allow {
    protocol = "udp"
    ports = ["1195-1203"]
  }

  source_tags = ["vns3"]
  target_tags = ["vns3"]
}

resource "google_compute_firewall" "internal_vns3_ipsec_4500_access" {
  name          = "${var.topology_name}-vns3-ipsec-4500"
  description   = "IPsec 4500 traffic between VNS3 Controllers"
  network       = var.network_id
  direction = "INGRESS"

  allow {
    protocol = "udp"
    ports = ["4500"]
  }

  source_tags = ["vns3"]
  target_tags = ["vns3"]
}

resource "google_compute_firewall" "admin_vns3_access" {
  count         = length(var.admin_cidrs) != 0 ? 1 : 0
  name          = "${var.topology_name}-vns3-admin-access"
  network       = var.network_id
  direction     = "INGRESS"
  source_ranges = var.admin_cidrs

  allow {
    protocol = "tcp"
    ports = ["8000"]
  }

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  target_tags = ["vns3"]
}

resource "google_compute_firewall" "overlay_access" {
  count         = length(var.overlay_cidrs) != 0 ? 1 : 0
  name          = "${var.topology_name}-vns3-overlay-access"
  network       = var.network_id
  direction     = "INGRESS"
  source_ranges = var.overlay_cidrs

  allow {
    protocol = "udp"
    ports = ["1194"]
  }

  target_tags = ["vns3"]
}

resource "google_compute_firewall" "ipsec_access" {
  count         = length(var.ipsec_cidrs) != 0 ? 1 : 0
  name          = "${var.topology_name}-vns3-ipsec-access"
  network       = var.network_id
  direction     = "INGRESS"
  source_ranges = var.ipsec_cidrs

  allow {
    protocol = "udp"
    ports = ["500"]
  }

  target_tags = ["vns3"]
}

resource "google_compute_firewall" "ipsec_nat_access" {
  count         = length(var.nat_ipsec_cidrs) != 0 ? 1 : 0
  name          = "${var.network_id}-vns3-native-ipsec-access"
  network       = var.network_id
  direction = "INGRESS"
  source_ranges = var.nat_ipsec_cidrs

  allow {
    protocol = "udp"
    ports = ["4500"]
  }

  target_tags = ["vns3"]
}

resource "google_compute_firewall" "ipsec_native_access" {
  count         = length(var.native_ipsec_cidrs) != 0 ? 1 : 0
  name          = "${var.network_id}-vns3-native-ipsec-access"
  network       = var.network_id
  direction = "INGRESS"
  source_ranges = var.native_ipsec_cidrs

  allow {
    protocol = "50"
  }

  target_tags = ["vns3"]
}