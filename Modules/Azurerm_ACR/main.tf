resource "azurerm_container_registry" "acr" {
for_each = var.acrs

  name                = each.value.acr-name
  resource_group_name = each.value.acr-rg-name
  location            = each.value.acr-location
  sku                 = each.value.acr-sku
  admin_enabled       = each.value.acr-admin-enabled

}