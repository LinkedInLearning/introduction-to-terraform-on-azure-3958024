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
    name            =   "rg-terraform-demo"
    location        =   "West US 2"
    tags            =   {
        environment =   "dev"
        project     =   "terraform-demo"
    }
}

# Create a virtual network
resource "azurerm_virtual_network" "main" {
    name            =   "vnet-terraform-demo"
    address_space   =   ["10.0.0.0/24"]
    location        =   azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    tags = {
        managed_by  =   "terraform"
        cost_center =   "engineering"
        owner       =   "devops-team"
    }
  
}