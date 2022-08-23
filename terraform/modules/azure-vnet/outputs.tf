output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "resource_group_id" {
  value = azurerm_resource_group.group.id
}

output "resource_group_name" {
  value = azurerm_resource_group.group.name
}

output "resource_group_location" {
  value = azurerm_resource_group.group.location
}

output "vnet_cidr" {
  value = azurerm_virtual_network.main.address_space
}

output "subnets" {
  value = var.subnets_private
}

output "subnet_ids" {
  value = azurerm_subnet.subnets_private.*.id
}

output "route_table_id" {
  value = azurerm_route_table.subnets_private.id
}

output "route_table_name" {
  value = azurerm_route_table.subnets_private.name
}