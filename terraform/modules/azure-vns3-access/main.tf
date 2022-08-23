resource "azurerm_public_ip" "controller_ip" {
  count               = length(var.controller_ids)
  name                = "${var.topology_name}-VNS3-PublicIP-${count.index}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"

  tags = var.common_tags
}

resource "azurerm_network_security_rule" "support_access" {
  name                        = "TempVNS3HTTPAccess"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8000"
  source_address_prefix       = var.access_cidr
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.security_group_name
}

resource "azurerm_route" "controller_support_access" {
  name                   = "${var.topology_name}-VNS3SupportAccess"
  resource_group_name    = var.resource_group_name
  route_table_name       = var.route_table_name
  address_prefix         = var.access_cidr
  next_hop_type          = "Internet"
}