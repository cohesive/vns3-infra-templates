resource "azurerm_resource_group" "group" {
  name     = var.resource_group_name
  location = var.vnet_region
}

resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
}

resource "azurerm_subnet" "subnets_private" {
  name                 = "${var.vnet_name}-sn-${count.index}"
  count                = length(var.subnets_private)
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = element(var.subnets_private, count.index)
}