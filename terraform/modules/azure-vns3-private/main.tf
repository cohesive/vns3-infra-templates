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
  }

  ip_configuration {
    name                          = "Secondary"
    subnet_id                     = element(var.subnet_ids, count.index)
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.common_tags
}


resource "azurerm_virtual_machine" "vns3" {
  count                 = length(var.subnet_ids)
  name                  = "${var.topology_name}-vns3-${count.index}"
  location                  = var.vns3_resource_group_location
  resource_group_name       = var.vns3_resource_group_name
  network_interface_ids = [element(azurerm_network_interface.vns3.*.id, count.index)]
  vm_size               = var.vns3_vm_size
  tags                  = var.common_tags

  storage_image_reference {
    publisher = "cohesive"
    offer     = "vns3_4x_network_security"
    sku       = var.vns3_sku
    version   = var.vns3_version
  }

  plan {
    name      = "cohesive-vns3-4_4_x-byol"
    publisher = "cohesive"
    product   = "vns3_4x_network_security"
  }

  storage_os_disk {
    name              = "vns3-disc"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.vns3_disk_type
  }
  os_profile {
    computer_name  = "vns3-${count.index}"
    admin_username = "vns3admin"
    admin_password = var.vns3_instance_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  depends_on = [azurerm_network_interface.vns3]
}