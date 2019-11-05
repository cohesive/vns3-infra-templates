resource "azurerm_public_ip" "vns3_public_ips" {
  count               = "${length(var.subnet_ids)}"
  name                = "${var.topology_name}-vns3-publicIP-${count.index}"
  location            = "${var.vns3_resource_group_location}"
  resource_group_name = "${var.vns3_resource_group_name}"
  allocation_method   = "Static"

  tags = "${var.common_tags}"
}

resource "azurerm_network_interface" "vns3" {
  name                      = "${var.topology_name}-vns3-ni-${count.index}"
  count                     = "${length(var.subnet_ids)}"
  location                  = "${var.vns3_resource_group_location}"
  resource_group_name       = "${var.vns3_resource_group_name}"
  network_security_group_id = "${azurerm_network_security_group.vns3_server_nsg.id}"
  enable_ip_forwarding      = true

  ip_configuration {
    name                          = "Primary"
    subnet_id                     = "${element(var.subnet_ids, count.index)}"
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = "${element(azurerm_public_ip.vns3_public_ips.*.id, count.index)}"
  }

  ip_configuration {
    name                          = "Secondary"
    subnet_id                     = "${element(var.subnet_ids, count.index)}"
    private_ip_address_allocation = "Dynamic"
  }

  tags = "${var.common_tags}"

  depends_on = ["azurerm_public_ip.vns3_public_ips"]
}


resource "azurerm_virtual_machine" "vns3" {
  count                 = "${length(var.subnet_ids)}"
  name                  = "${var.topology_name}-vns3-${count.index}"
  location                  = "${var.vns3_resource_group_location}"
  resource_group_name       = "${var.vns3_resource_group_name}"
  network_interface_ids = ["${element(azurerm_network_interface.vns3.*.id, count.index)}"]
  vm_size               = "${var.vns3_vm_size}"
  tags                  = "${var.common_tags}"

  storage_image_reference {
    # publisher = "cohesive"
    # offer     = "vns3_4x_network_security"
    # sku       = "${var.vns3_sku}"
    # version   = "${var.vns3_version}"
    id          = "/subscriptions/b5bf953c-3d81-4cc5-b393-3e160d856f4d/resourceGroups/rck_central-us_resources/providers/Microsoft.Compute/images/vnscubed482-20190918-azure-byol-rck"
  }

  # plan {
  #   name      = "cohesive-vns3-4_4_x-byol"
  #   publisher = "cohesive"
  #   product   = "vns3_4x_network_security"
  # }

  storage_os_disk {
    name              = "vns3-disc"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.vns3_disk_type}"
  }
  os_profile {
    computer_name  = "vns3-${count.index}"
    admin_username = "vns3admin"
    admin_password = "${var.vns3_instance_password}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  depends_on = ["azurerm_network_interface.vns3"]
}

resource "azurerm_route" "controller_support_access" {
  name                   = "${var.topology_name}-teamsupport-access"
  resource_group_name    = "${var.vns3_resource_group_name}"
  route_table_name       = "${var.route_table_name}"
  address_prefix         = "${var.access_cidr}"
  next_hop_type          = "Internet"
}