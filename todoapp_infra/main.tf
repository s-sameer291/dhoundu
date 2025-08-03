module "resource_group" {
  source                  = "../Module/azurerm_resource_group"
  resource_group_name     = "todo_app"
  resource_group_location = "centralindia"
}

# module "virtual_network_location" {
#   depends_on = [ module.resource_group ]
#   source                   = "../Module/azurerm_virtual_network"
#   virtual_network_name     = "todo_vnet"
#   virtual_network_location = "centralindia"
#   resource_group_name      = "todo_app"
#   address_space            = ["10.0.0.0/16"]

# }

# module "frontendsubnet" {
#   depends_on = [ module.virtual_network_location ]
#   source               = "../Module/azurerm_subnet"
#   subnet_name          = "frontend_subnet"
#   resource_group_name  = "todo_app"
#   virtual_network_name = "todo_vnet"
#   address_prefixes     = ["10.0.1.0/24"]
# }

# module "backendsubnet" {
#   depends_on = [ module.virtual_network_location ]
#   source               = "../Module/azurerm_subnet"
#   subnet_name          = "backend_subnet"
#   resource_group_name  = "todo_app"
#   virtual_network_name = "todo_vnet"
#   address_prefixes     = ["10.0.2.0/24"]
# }

# # module "public_ip" {
# #   depends_on = [ module.resource_group ]
# #   source                  = "../Module/azurerm_pip"
# #   pip                     = "todo_ft"
# #   resource_group_name     = "todo_app"
# #   resource_group_location = "centralindia"

# # }

# module "public_ip_backend" {
#   depends_on = [ module.resource_group ]
#   source                  = "../Module/azurerm_pip"
#   pip                     = "backend_ip"
#   resource_group_name     = "todo_app"
#   resource_group_location = "centralindia"

# }

# module "virtual_machine_frontend" {
#   depends_on = [ module.frontendsubnet, module.public_ip ]
#   source                  = "../Module/azurerm_virtual_machine"
#   nic_name                = "frontend_nic"
#   resource_group_name     = "todo_app"
#   resource_group_location = "centralindia"
#   virtual_machine_name    = "frontendvm"
#   vm_size                 = "Standard_B1s"
#   username                = "devopsadmin"
#   admin_password          = "Sam@ars290422"
#   image_publisher         = "Canonical"
#   image_offer             = "0001-com-ubuntu-server-focal"
#   image_sku               = "20_04-lts"
#   image_version           = "latest"
#   subnet_name = "frontend_subnet"
#   virtual_network_name = "todo_vnet"
#   PIP_name = "todo_ft"
# }


# module "virtual_machine_backend" {
#   depends_on = [ module.backendsubnet, module.public_ip_backend ]
#   source                  = "../Module/azurerm_virtual_machine"
#   nic_name                = "backend_nic"
#   resource_group_name     = "todo_app"
#   resource_group_location = "centralindia"
#   virtual_machine_name    = "backendvm"
#   vm_size                 = "Standard_B1s"
#   username                = "devopsadmin"
#   admin_password          = "Sam@ars290422"
#   image_publisher         = "Canonical"
#   image_offer             = "0001-com-ubuntu-server-focal"
#   image_sku               = "20_04-lts"
#   image_version           = "latest"
#   subnet_name = "backend_subnet"
#   virtual_network_name = "todo_vnet"
#   PIP_name = "backend_ip"
# }

# module "todosql" {
#   depends_on = [ module.resource_group ]
#   source                  = "../Module/azurerm_sql_server"
#   server_name             = "todoserversion1"
#   resource_group_name     = "todo_app"
#   resource_group_location = "centralindia"
#   username                = "devopsadmin"
#   admin_password          = "Sam@ars290422"
# }

# module "azurerm_mssql_database" {
#   depends_on = [ module.todosql ]
#   source        = "../Module/azurerm_sql_database"
#   database_name = "tododatabase1"
#   server_name             = "todoserversion1"
#   resource_group_name     = "todo_app"
# }

module "azurerm_key_vault" {
  depends_on          = [module.resource_group]
  source              = "../Module/azurerm_keyvault"
  keyvault_name       = "mykey2903121"
  location            = "centralindia"
  resource_group_name = "todo_app"
}

module "username" {
  depends_on          = [module.resource_group, module.azurerm_key_vault]
  source              = "../Module/azurerm_keyvault_secret"
  keyvault_name       = "mykey2903121"
  resource_group_name = "todo_app"
  secret_name         = "username"
  secret_value        = "devadmin"
}

module "admin_password" {
  depends_on          = [module.resource_group, module.azurerm_key_vault]
  source              = "../Module/azurerm_keyvault_secret"
  keyvault_name       = "mykey2903121"
  resource_group_name = "todo_app"
  secret_name         = "password"
  secret_value        = "devops@12345"
}