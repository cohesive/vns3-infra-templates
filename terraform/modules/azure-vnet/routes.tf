resource "azurerm_route_table" "subnets_private" {
  name                          = "${var.vnet_name}-rt-main"
  location                      = azurerm_resource_group.group.location
  resource_group_name           = azurerm_resource_group.group.name
  tags             = var.common_tags
}

resource "azurerm_subnet_route_table_association" "subnets_private" {
  count          = length(azurerm_subnet.subnets_private)
  subnet_id      = length(azurerm_subnet.subnets_private) == 0 ? null : element(azurerm_subnet.subnets_private.*.id, count.index)
  route_table_id = azurerm_route_table.subnets_private.id
}