resource "azurerm_network_security_group" "nsg1" {
  name                = "${local.env}-${local.region}-nsg01"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
}

resource "azurerm_subnet_network_security_group_association" "subnet1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

resource "azurerm_network_security_rule" "nsg1rule1" {
  name                         = "RDPInbound"
  priority                     = 1000
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_range       = "3389"
  source_address_prefixes      = var.inbound_whitelist
  destination_address_prefix   = "*"
  resource_group_name          = azurerm_resource_group.network.name
  network_security_group_name  = azurerm_network_security_group.nsg1.name
}

resource "azurerm_network_security_group" "nsg2" {
  name                = "${local.env}-${local.region}-nsg02"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
}

resource "azurerm_subnet_network_security_group_association" "subnet2" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}
/*
resource "azurerm_network_security_group" "nsg3" {
  name                = "${local.env}${local.env}-${local.region}-${var.app}-nsg03"
  location            = "${azurerm_resource_group.network.location}"
  resource_group_name = "${azurerm_resource_group.network.name}"
}

resource "azurerm_subnet_network_security_group_association" "subnet3" {
  subnet_id                 = "${azurerm_subnet.subnet3.id}"
  network_security_group_id = "${azurerm_network_security_group.nsg3.id}"
}
*/