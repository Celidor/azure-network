resource "random_string" "value" {
  length           = 25
  special          = true
  override_special = "-"
  min_lower        = 1
  min_upper        = 1
  min_special      = 1
  min_numeric      = 1
}

resource "azurerm_network_interface" "linux" {
  name                = "${local.env}-${local.region}-linux-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.network.name

  ip_configuration {
    name                          = "${local.env}-${local.region}-linux-ipc"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "linux" {
  name                             = "${local.env}${local.region}linux"
  location                         = var.location
  resource_group_name              = data.azurerm_resource_group.network.name
  network_interface_ids            = [azurerm_network_interface.linux.id]
  vm_size                          = var.vm_size
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${local.env}${local.region}linux"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${local.env}${local.region}linux"
    admin_username = "localadmin"
    admin_password = random_string.value.result
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = local.env
  }
}
