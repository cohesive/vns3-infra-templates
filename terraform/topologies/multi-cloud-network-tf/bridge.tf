
// AWS
// AWS Routing
resource "aws_route" "to_bridge" {
  route_table_id              = module.aws_vpc.route_table_id
  destination_cidr_block      = var.vnet_cidr
  network_interface_id        = element(module.aws_vns3.vns3_network_interfaces, 0)
}

resource "aws_route" "to_azure_vns3" {
  route_table_id              = module.aws_vpc.route_table_id
  destination_cidr_block      = "${element(module.azure_vns3.vns3_public_ips, 0)}/32"
  gateway_id                  = module.aws_vns3.internet_gateway_id

  timeouts {
    create = "10m"
  }
}

// AWS Firewall
resource "aws_security_group_rule" "allow_azure_udp_500" {
  type            = "ingress"
  from_port       = 500
  to_port         = 500
  protocol        = "UDP"
  cidr_blocks = ["${element(module.azure_vns3.vns3_public_ips, 0)}/32"]
  security_group_id = module.aws_vns3.vns3_sg
}

resource "aws_security_group_rule" "allow_azure_udp_4500" {
  type            = "ingress"
  from_port       = 4500
  to_port         = 4500
  protocol        = "UDP"
  cidr_blocks = ["${element(module.azure_vns3.vns3_public_ips, 0)}/32"]
  security_group_id = module.aws_vns3.vns3_sg
}

// Azure
// Azure Routing
resource "azurerm_route" "to_bridge" {
  name                   = "${var.topology_name}-aws-bridge"
  resource_group_name    = module.azure_vnet.resource_group_name
  route_table_name       = module.azure_vnet.route_table_name
  address_prefix         = var.vpc_cidr
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = element(module.azure_vns3.vns3_primary_ips, 0)
}

resource "azurerm_route" "to_aws_vns3" {
  name                   = "${var.topology_name}-aws-internet"
  resource_group_name    = module.azure_vnet.resource_group_name
  route_table_name       = module.azure_vnet.route_table_name
  address_prefix         = "${element(module.aws_vns3.vns3_public_ips, 0)}/32"
  next_hop_type          = "Internet"
}


// Azure Firewall
resource "azurerm_network_security_rule" "inbound_aws_udp_4500" {
  name                        = "AllowInboundAWSUDP4500"
  priority                    = 301
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "4500"
  source_address_prefix       = "${element(module.aws_vns3.vns3_public_ips, 0)}/32"
  destination_address_prefix  = "*"
  resource_group_name         = module.azure_vnet.resource_group_name
  network_security_group_name = module.azure_vns3.vns3_nsg_name
}

resource "azurerm_network_security_rule" "allow_aws_udp_500" {
  name                        = "AllowInboundAWSUDP500"
  priority                    = 302
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "500"
  source_address_prefix       = "${element(module.aws_vns3.vns3_public_ips, 0)}/32"
  destination_address_prefix  = "*"
  resource_group_name         = module.azure_vnet.resource_group_name
  network_security_group_name = module.azure_vns3.vns3_nsg_name
}


resource "azurerm_network_security_rule" "outbound_aws_udp" {
  name                        = "AllowAllAccessAWSUDP"
  priority                    = 201
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "${element(module.aws_vns3.vns3_public_ips, 0)}/32"
  resource_group_name         = module.azure_vnet.resource_group_name
  network_security_group_name = module.azure_vns3.vns3_nsg_name
}