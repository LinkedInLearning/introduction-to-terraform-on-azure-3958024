variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "team_name" {
  description = "The name of the team responsible for the project"
  type        = string
}

variable "environment" {
  description = "The environment for the resources (eg dev, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], lower(var.environment))
    error_message = "The environment must be one of: dev, staging, prod"
  }

}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "West US 2"
}

variable "vm_count" {
  description = "The number of virtual machines to create"
  type        = number
  default     = 1

  validation {
    condition     = var.vm_count >= 1 && var.vm_count <= 5
    error_message = "The vm_count must be a positive integer, from 1 to 5"
  }
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "address_space" {
  description = "The address space for the virtual machine"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "the address prefixes for the subnet"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
}
