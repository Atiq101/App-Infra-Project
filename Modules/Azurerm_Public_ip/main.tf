resource "azurerm_public_ip" "public-ip" {
  for_each = var.pips 
  name                = each.value.pip-name
  location            = each.value.pip-location
  resource_group_name = each.value.pip-rg-name
  allocation_method   = each.value.pip-allocation-methord
}