resource "azurerm_mssql_server" "Sql-Server" {

  for_each = var.sql_servers

  name                         = each.value.sqlserver-name
  resource_group_name          = each.value.sql-rg-name
  location                     = each.value.sql-rg-location
  version                      = each.value.sql-server-version
  administrator_login          = each.value.sql-admin-login
  administrator_login_password = each.value.sql-admin-password
  minimum_tls_version          = each.value.sql-minimum_tls_version 

 
}