module "rg" {
  source = "../../Modules/Azurerm_Resource_Group"
  rgs    = var.rgs

}

module "network" {
  depends_on = [module.rg]
  source     = "../../Modules/Azurerm_Networks"
  networks   = var.networks
}

module "pip" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_public_ip"
  pips       = var.pips
}

module "linux-vm" {
  depends_on = [module.network, module.pip]
  source     = "../../Modules/Azurerm_LinuxVM"
  vms        = var.vms
}

module "Sql-Server" {
  depends_on  = [module.rg]
  source      = "../../Modules/Azurem_Sql_Server"
  sql_servers = var.sql_servers
}

module "sql-db" {
  depends_on = [module.Sql-Server, module.rg]
  source     = "../../Modules/Azurerm_SQL_Database"
  dbs        = var.dbs
}

module "acr" {
  depends_on = [ module.rg ]
  source = "../../Modules/Azurerm_ACR"  
  acrs =var.acr
 }

module "aks" {
depends_on = [ module.rg ]
source="../../Modules/Azurerm_AKS"
akss = var.akss


}