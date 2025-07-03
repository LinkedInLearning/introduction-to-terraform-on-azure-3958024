# Configure Azure Provider
terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.20.0"
    }
  }
}

#Configure the Azure provider features
provider "azurerm" {
  subscription_id = "provide your Azure subscription ID here"
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "main" {
    name            =   "rg-${var.environment}-${var.project_name}"
    location        =   var.location
    tags            =   var.tags
}

# Create a virtual network
resource "azurerm_virtual_network" "main" {
    name            =   "vnet-${var.environment}-${var.project_name}"
    address_space   =   var.address_space
    location        =   azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    tags = merge(var.tags, {
        project_code    =   "234343"
    })
  
}