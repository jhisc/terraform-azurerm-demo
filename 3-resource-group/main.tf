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