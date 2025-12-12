resource "azurerm_virtual_network" "network"{
  for_each = var.networks
  name                = each.value.vnet-name
  location            = each.value.location
  resource_group_name = each.value.rg-name
  address_space       = each.value.vnet-cidr
  dns_servers         = each.value.vnet-dns

  dynamic "subnet" {
       for_each = each.value.subnets
       content {
         name = subnet.value.subnet-name 
         address_prefixes = subnet.value.subnet-cidr
       }

  }
  


}