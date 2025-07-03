variable "location" {
    description = "The Azure region where resources will be created"
    type        = string
    default     = "West US 2"
}

variable "environment" {
    description = "The environment for resource eg dev, staging, prod"
    type        = string
    default     = "dev"
}

variable "resource_group_name" {
    description     = "The name of the resource group"
    type            = string
    default         = "rg-terraform-demo"
}

variable "tags" {
    description = "Tags to apply to resources"
    type = map(string)
    default = {
        managed_by  = "terraform"
        cost_center =   "engineering"
        owner       =   "devops-team"
    }
}

variable "virtual_network_name" {
    description     =   "The name of the vnet"
    type            =   string
    default         =   "vnet-terraform-demo"
  
}

variable "address_space" {
    description = "The address space for the virtual network"
    type = list(string)
    default = [ "10.0.0.0/24" ]
  
}

variable "subnet_address_prefixes" {
    description = "The address prefixes for the subnet"
    type = list(string)
    default = [ "10.0.0.0/28" ]
}

variable "project_name" {
    description = "The name of the project"
    type = string
  
}