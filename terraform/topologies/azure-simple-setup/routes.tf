# // Azure

# // Azure Routing
# resource "azurerm_route" "to_bridge" {
#   count                  = length(module.azure_vns3.vns3_primary_ips) > 0 ? length(var.aws_routable_cidrs) : 0
#   name                   = var.topology_name}-aws-bridge-${count.index + 1
#   resource_group_name    = module.azure_vnet.resource_group_name
#   route_table_name       = module.azure_vnet.route_table_name
#   address_prefix         = element(var.aws_routable_cidrs, count.index)
#   next_hop_type          = "VirtualAppliance"
#   # next hop set to primary controllers private IP
#   next_hop_in_ip_address = element(module.azure_vns3.vns3_primary_ips, 0)

#   depends_on = [
#     module.azure_vnet.route_table_name,
#     module.azure_vnet.resource_group_name,
#     module.azure_vns3.vns3_primary_ips
#   ]
# }

# resource "azurerm_route" "to_aws_vns3" {
#   count                  = length(module.aws_vns3.vns3_public_ips)
#   name                   = var.topology_name}-aws-internet-${count.index + 1
#   resource_group_name    = module.azure_vnet.resource_group_name
#   route_table_name       = module.azure_vnet.route_table_name
#   address_prefix         = "${element(module.aws_vns3.vns3_public_ips, count.index)}/32"
#   next_hop_type          = "Internet"
# }

# // Azure Firewall
# resource "azurerm_network_security_rule" "allow_aws_peering" {
#   name                        = "AllowInboundAWSVNS3PeeringUDP${count.index + 1}"
#   count                       = length(module.aws_vns3.vns3_public_ips)
#   priority                    = 301 + count.index
#   description                 = ""
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Udp"
#   source_port_range           = "*"
#   destination_port_range      = "1195-1203"
#   source_address_prefix       = "${element(module.aws_vns3.vns3_public_ips, count.index)}/32"
#   destination_address_prefix  = "*"
#   resource_group_name         = module.azure_vnet.resource_group_name
#   network_security_group_name = module.azure_vns3.vns3_nsg_name
# }

# resource "azurerm_network_security_rule" "outbound_aws_udp" {
#   name                        = "AllowAllAccessAWSUDP"
#   count                       = length(module.aws_vns3.vns3_public_ips)
#   description                 = ""
#   priority                    = 201 + count.index
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Udp"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "${element(module.aws_vns3.vns3_public_ips, count.index)}/32"
#   resource_group_name         = module.azure_vnet.resource_group_name
#   network_security_group_name = module.azure_vns3.vns3_nsg_name
# }