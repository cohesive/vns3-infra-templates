output "vns3_instances" {
  value = google_compute_instance.vns3.*.id
}
output "vns3_instance_ids" {
  value = google_compute_instance.vns3.*.instance_id
}

output "vns3_primary_ips" {
  value = google_compute_instance.vns3.*.network_interface.0.network_ip
}

output "vns3_public_ips" {
  value = google_compute_instance.vns3.*.network_interface.0.access_config.0.nat_ip
}