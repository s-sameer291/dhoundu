data "azurerm_public_ip" "PIP" {
  name                = var.PIP_name
  resource_group_name = var.resource_group_name 
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name 
}




resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.PIP.id
  }
}

resource "azurerm_linux_virtual_machine" "frontend_vm" {
  name                = var.virtual_machine_name
  resource_group_name = var.resource_group_name 
  location            = var.resource_group_location
  size                = var.vm_size
  admin_username      = var.username
  admin_password =      var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher # Published ID from Azure Marketplace
    offer     = var.image_offer     # Product ID from Azure Marketplace
    sku       = var.image_sku       # Plan ID from Azure Marketplace
    version   = var.image_version   # Version of the image
  }
}