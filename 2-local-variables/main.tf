provider "azurerm" {
  features {}
}

locals {
  tags = {
    "purpose" = "demo",
    "repo"    = "https://github.com/jhisc/terraform-azurerm-demo/"
  }
}

# Example Usage
output "tags" {
  value = local.tags
}