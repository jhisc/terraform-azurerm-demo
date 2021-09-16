variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "The azure region to deploy resources in"
  type        = string
  default = "East US 2"
}