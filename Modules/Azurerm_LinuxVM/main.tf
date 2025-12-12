data "azurerm_public_ip" "pipm" {
 for_each =  var.vms
  name                = each.value.pip-name
  resource_group_name = each.value.pip-rg
}

data "azurerm_subnet" "subnet" {
 for_each = var.vms
name                 = each.value.subnet-name
virtual_network_name = each.value.vnet-name
resource_group_name  = each.value.rg-name
}



resource "azurerm_network_interface" "nic" {
    for_each = var.vms
  name                = each.value.nic-name
  location            = each.value.nic-location
  resource_group_name = each.value.nic-rg-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.pipm[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "linux-vm" {
  for_each = var.vms
  name                = each.value.vm-name
  resource_group_name = each.value.vm-rg-name
  location            = each.value.vm-rg-location
  size                = each.value.vm-size
  admin_username      = each.value.vm-admin
  admin_password      = each.value.vm-password
  disable_password_authentication = false
  custom_data = base64encode(file(each.value.script_name))
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

source_image_reference {
    publisher = each.value.source_image_reference.image_publisher
    offer     = each.value.source_image_reference.image_offer
    sku       = each.value.source_image_reference.image_sku
    version   = each.value.source_image_reference.image_version

}
}
