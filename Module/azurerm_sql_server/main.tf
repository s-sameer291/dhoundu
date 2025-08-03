resource "azurerm_mssql_server" "todosql" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = "12.0"
  administrator_login          = var.username
  administrator_login_password = var.admin_password
  

 

}