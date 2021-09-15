resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "East US 2"

  tags = local.tags
}
