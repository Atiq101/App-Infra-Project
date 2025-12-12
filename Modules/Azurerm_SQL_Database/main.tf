resource "azurerm_mssql_database" "sql-db" {

for_each = var.dbs
  name         = each.value.db-name
  server_id    = data.azurerm_mssql_server.sqlserver[each.key].id
  collation    = each.value.db-server_collation
  license_type = each.value.db-server_license-type
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
}

data "azurerm_mssql_server" "sqlserver" {

for_each = var.dbs
  name                = each.value.sqlserver-name
  resource_group_name = each.value.sqlserver-rg-name
}
