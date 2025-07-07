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

locals {
  environment_config = {
    default = {
      vm_size   =   "Standard_B1s"
      vm_count  =   1
    }

    dev = {
      vm_size   =   "Standard_B1s"
      vm_count  =   1
    }
    
    prod  = {
      vm_size   =   "Standard_DS1_v2"
      vm_count  =   2
    }
  }

  current_config  = local.environment_config[terraform.workspace]
}

# Create a resource group
resource "azurerm_resource_group" "main" {
    name            =   "rg-${terraform.workspace}-${var.project_name}"
    location        =   var.location
    tags            =   {
        environment =   terraform.workspace
        project     =   "terraform-demo"
    }
}

# Create a virtual network
resource "azurerm_virtual_network" "main" {
    name            =   "vnet-${terraform.workspace}-${var.project_name}"
    address_space   =   var.address_space
    location        =   azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

    tags = merge(var.tags,{
      project_code  = "233323"
    })
}

resource "azurerm_subnet" "main" {
  name = "subnet-${terraform.workspace}-${var.project_name}"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = var.subnet_address_prefixes
}

resource "azurerm_network_interface" "main" {
  count = local.current_config.vm_count
  name = "nic-${terraform.workspace}-${var.project_name}-${count.index + 1}"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name = "ipconfig-${terraform.workspace}-${var.project_name}-${count.index + 1}"
    subnet_id = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = merge(var.tags, {
    environment = terraform.workspace
    project_code  = "122212"
  })
}

resource "azurerm_linux_virtual_machine" "main" {
  count = local.current_config.vm_count
  name                = "vm-${terraform.workspace}-${var.project_name}-${count.index + 1}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = local.current_config.vm_size

  disable_password_authentication = false
  admin_username      = "adminuser"
  admin_password = "P@ssword1234!"
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = merge(var.tags, {
    environment = terraform.workspace
  })
}