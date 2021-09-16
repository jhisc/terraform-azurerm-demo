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