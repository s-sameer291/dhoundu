resource "azurerm_public_ip" "PIP" {
  name                = var.pip
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"


}