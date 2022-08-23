resource "azurerm_public_ip" "vns3_public_ips" {
  count               = length(var.subnet_ids)
  name                = "${var.topology_name}-vns3-publicIP-${count.index}"
  location            = var.vns3_resource_group_location
  resource_group_name = var.vns3_resource_group_name
  allocation_method   = "Static"

  tags = var.common_tags
}

resource "azurerm_network_interface" "vns3" {
  name                      = "${var.topology_name}-vns3-ni-${count.index}"
  count                     = length(var.subnet_ids)
  location                  = var.vns3_resource_group_location
  resource_group_name       = var.vns3_resource_group_name
  network_security_group_id = azurerm_network_security_group.vns3_server_nsg.id
  enable_ip_forwarding      = true

  ip_configuration {
    name                          = "Primary"
    subnet_id                     = element(var.subnet_ids, count.index)
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = element(azurerm_public_ip.vns3_public_ips.*.id, count.index)
  }

  ip_configuration {
    name                          = "Secondary"
    subnet_id                     = element(var.subnet_ids, count.index)
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.common_tags

  depends_on = [azurerm_public_ip.vns3_public_ips]
}


resource "azurerm_virtual_machine" "vns3" {
  count                 = length(var.subnet_ids)
  name                  = "${var.topology_name}-vns3-${count.index}"
  location                  = var.vns3_resource_group_location
  resource_group_name       = var.vns3_resource_group_name
  network_interface_ids = [element(azurerm_network_interface.vns3.*.id, count.index)]
  vm_size               = var.vns3_vm_size
  tags                  = var.common_tags

  identity {
    type = "SystemAssigned"
  }

  storage_image_reference {
    publisher = "cohesive"
    offer     = "vns3_4x_network_security"
    sku       = var.vns3_sku
    version   = "latest"
  }

  plan {
    name      = var.vns3_sku
    publisher = "cohesive"
    product   = "vns3_4x_network_security"
  }

  storage_os_disk {
    name              = "${var.topology_name}-vns3-${count.index}-disc"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.vns3_disk_type
  }
  os_profile {
    computer_name  = "${var.topology_name}-vns3-${count.index}"
    admin_username = "vns3admin"
    admin_password = var.vns3_instance_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  depends_on = ["azurerm_network_interface.vns3"]
}

resource "azurerm_route" "controller_support_access" {
  name                   = "${var.topology_name}-teamsupport-access"
  resource_group_name    = var.vns3_resource_group_name
  route_table_name       = var.route_table_name
  address_prefix         = var.access_cidr
  next_hop_type          = "Internet"
}

data "azurerm_subscription" "current" {}

resource "azurerm_role_definition" "vns3_ha" {
  name        = "VNS3-HA-Route-Table-Update"
  scope       = data.azurerm_subscription.current.id
  description = "Allow the VNS3 HA Primary selfish plugin to Update Azure Route Table Entries"

  permissions {
    actions     = [
        "Microsoft.Compute/virtualMachines/read",
        "Microsoft.Network/networkInterfaces/read",
        "Microsoft.Network/virtualNetworks/read",
        "Microsoft.Network/publicIPAddresses/read",
        "Microsoft.Network/routeTables/read",
        "Microsoft.Network/routeTables/routes/read",
        "Microsoft.Network/routeTables/routes/write"
    ]
    not_actions = []
  }

  assignable_scopes = [
    "${data.azurerm_subscription.current.id}/resourceGroups/${var.vns3_resource_group_name}"
  ]
}

resource "azurerm_role_assignment" "vns3_service_principal" {
  count              = length(azurerm_virtual_machine.vns3)
  scope              = "${data.azurerm_subscription.current.id}/resourceGroups/${var.vns3_resource_group_name}"
  role_definition_id = azurerm_role_definition.vns3_ha.id
  principal_id       = lookup(azurerm_virtual_machine.vns3[count.index].identity[0], "principal_id")
}