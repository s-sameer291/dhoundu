resource "azurerm_mssql_database" "example" {
  name         = var.database_name
  server_id    = data.azurerm_mssql_server.tososerver.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
 
}


data "azurerm_mssql_server" "tososerver" {
  name                = var.server_name
  resource_group_name = var.resource_group_name
}