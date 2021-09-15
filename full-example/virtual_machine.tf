resource "random_password" "password" {
  length  = 16
  special = false
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-virtual-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = random_password.password.result
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}