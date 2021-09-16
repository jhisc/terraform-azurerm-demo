provider "azurerm" {
  features {}
}

locals {
  tags = {
    "purpose" = "demo",
    "repo"    = "https://github.com/jhisc/terraform-azurerm-demo/"
  }
}

variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "The azure region to deploy resources in"
  type        = string
  default = "East US 2"
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location

  tags = local.tags
}

resource "azurerm_virtual_network" "example" {
  name                = "example-virtual-network"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]

  tags = local.tags
}

resource "azurerm_subnet" "private" {
  name                 = "private"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/16"]
}

resource "azurerm_network_interface" "example" {
  name                = "example-network-interface"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Dynamic"
  }
}

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