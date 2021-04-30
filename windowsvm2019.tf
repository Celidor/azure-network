resource "azurerm_public_ip" "winvmip" {
  name                = "${local.env}-${local.region}-windows-ip"
  resource_group_name = data.azurerm_resource_group.network.name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "random_string" "windows" {
  length = 25
  special = true
  override_special = "-"
}

resource "azurerm_network_interface" "windows" {
  name                = "${local.env}-${local.region}-windows-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.network.name

  ip_configuration {
    name                          = "${local.env}-${local.region}-windows-ipc"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.winvmip.id
  }
}

resource "azurerm_virtual_machine" "windows" {
  name                             = "${local.env}${local.region}windows"
  location                         = var.location
  resource_group_name              = data.azurerm_resource_group.network.name
  network_interface_ids            = [azurerm_network_interface.windows.id]
  vm_size                          = var.vm_size
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${local.env}${local.region}windows"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${local.env}${local.region}windows"
    admin_username = "localadmin"
    admin_password = random_string.windows.result
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  tags = {
    environment = local.env
  }
}
