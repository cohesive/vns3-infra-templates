
output "vns3_vm_ids" {
  value = azurerm_virtual_machine.vns3.*.id
}

output "vns3_nsg_id" {
  value = azurerm_network_security_group.vns3_server_nsg.id
}

output "vns3_nsg_name" {
  value = azurerm_network_security_group.vns3_server_nsg.name
}

output "vns3_primary_ips" {
  value = azurerm_network_interface.vns3.*.private_ip_address
}

output "vns3_instance_names" {
  value = azurerm_virtual_machine.vns3.*.name
}

output "vns3_network_interfaces" {
  value = azurerm_network_interface.vns3.*.id
}

output "vns3_public_ips" {
  value = azurerm_public_ip.vns3_public_ips.*.ip_address
}