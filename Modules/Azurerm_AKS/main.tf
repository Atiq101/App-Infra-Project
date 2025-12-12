
resource "azurerm_kubernetes_cluster" "aks" {
    for_each = var.akss

    name                = each.value.aks-name
    location            = each.value.rg-location
    resource_group_name = each.value.rg-name
    dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

}

