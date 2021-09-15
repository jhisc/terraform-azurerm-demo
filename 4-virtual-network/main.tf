provider "azurerm" {
  features {}
}

locals {
  tags = {
    "purpose" = "demo",
    "repo"    = "https://github.com/jhisc/terraform-azurerm-demo/"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "East US 2"

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

