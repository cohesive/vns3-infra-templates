output "vns3_ips" {
  value = azurerm_public_ip.controller_ip.*.ip_address
}
