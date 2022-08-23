resource "azurerm_network_security_group" "vns3_server_nsg" {
  name                = "${var.topology_name}-vns3-nsg"
  location                  = var.vns3_resource_group_location
  resource_group_name       = var.vns3_resource_group_name

  // Outbound rules

  security_rule {
    name                       = "AllowVnetVNS3Http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_port_range     = "8000"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowSupportCidrVNS3Http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = var.access_cidr
    destination_port_range     = "8000"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowVnetVNS3Peering"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "1195-1197"
    destination_port_range     = "1195-1197"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowVNetInboundIPsecPhase1"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "500"
    destination_port_range     = "500"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowVNetInboundIPsecPhase2"
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "UDP"
    source_port_range          = "4500"
    destination_port_range     = "4500"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowAllVNETInbound"
    priority                   = 600
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  // Outbound rules
  security_rule {
    name                       = "AllowAllAccessCidrOutbound"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.access_cidr
  }
}

resource "azurerm_subnet_network_security_group_association" "test" {
  count                     = length(var.subnet_ids)
  subnet_id                 = element(var.subnet_ids, count.index)
  network_security_group_id = azurerm_network_security_group.vns3_server_nsg.id
}