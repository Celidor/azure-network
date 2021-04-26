resource "azurerm_virtual_network" "network" {
  name                = "${local.env}-${local.region}-vnet"
  location            = data.azurerm_resource_group.network.location
  resource_group_name = data.azurerm_resource_group.network.name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "subnet1" {
  name                      = var.subnet1_name
  resource_group_name       = data.azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.network.name
  address_prefixes          = [var.subnet1_address_space]
}

resource "azurerm_subnet" "subnet2" {
  name                      = var.subnet2_name
  resource_group_name       = data.azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.network.name
  address_prefixes          = [var.subnet2_address_space]
}
