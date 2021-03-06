# Technology Summit Examples - 2021

## Overview

These examples are designed to demonstrate a variety of terrfaorm configurations and commands. They should **NOT** be used in any production environments and are stricly for educational purposes. All examples should be run in a development or sandbox environment.<br />

---
## 1) AzureRM Provider
The Azure Resource Manager (RM) provider is used to communicate with the Azure API. This covers all azure services outside of Active Directory which would require the AzureAD provider. By default the provider will use Azure CLI credentials but this can be overriden if needed.
<br />
The provider.tf file in this repository will use the CLI credentals present on your machine. These credentials can be generated by running the `az login` command.
<br />
The following example shows how to override the default behaviour by providing user credentials:
```
provider "azurerm" {
  features {}

  client_id       = ""
  client_secret   = ""
  environment     = "public"
  subscription_id = ""
}
```
[Resource  Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
<br />

---
## 2) Local Variables
Local Variables allow you to define a value once and re-use it many times. This is particulary useful for something like resource tags, where we want the value to be consistant across all resources.<br />
[Terraform Documentation](https://www.terraform.io/docs/language/values/locals.html)<br />

---
## 3) Resource Groups
A resource group is an azure "container" that holds related resources within a subscription. Deleting a resource group will also delete the resources within it. This is a fundamental building block in all Azure deployments.<br />
[Terraform Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)<br />

---
## 4) Virtual Networks
This example introduces the concept of passing values between resources. We are using the outputs of our resource group to help provision the virtual network. This will create dependancy between resources and enable us to provision resources using dynamic values that may not be known until the apply is in progress.<br />
[Terraform Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)<br />

---
## 5) Virtual Machine
Our final example pulls together all of the previous steps to create a virtual machine. This demonstrats how all of the components interact with one another to create a useable cloud environment.<br />
[Terraform Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)<br />
