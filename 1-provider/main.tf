provider "azurerm" {
  features {}
}

# Example Usage
data "azurerm_client_config" "current" {
}

output "account_id" {
  value = data.azurerm_client_config.current.client_id
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}