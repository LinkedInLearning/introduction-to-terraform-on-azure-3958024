# Configure Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "<YOUR_UNIQUE_STORAGE_ACCOUNT_NAME>"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

#Configure the Azure provider features
provider "azurerm" {
  subscription_id = "provide your Azure subscription ID here"
  features {}
}

module "compute" {
  source = "./modules/compute"

  project_name            = "projkpi"
  team_name               = var.team_name
  environment             = var.environment
  location                = var.location
  address_space           = var.address_space
  subnet_address_prefixes = var.subnet_address_prefixes
  vm_count                = var.vm_count
  vm_size                 = var.vm_size
  tags                    = var.tags
}

module "database" {
  source = "./modules/database"

  project_name   = "projkpi"
  environment    = var.environment
  location       = var.location
  admin_password = var.database_password
  database_sku   = var.database_sku
  tags           = var.tags
}

module "web_app" {
  source = "./modules/web-app"

  project_name               = "projkpi"
  environment                = var.environment
  location                   = var.location
  app_service_sku            = var.app_service_sku
  database_connection_string = module.database.connection_string
  tags                       = var.tags
}
