variable "project_name" {
  description = "The name of the project"
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

variable "admin_username" {
  description = "Database administrator username"
  type        = string
  default     = "sqladmin"
}

variable "admin_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "database_sku" {
  description = "Database sku/tier"
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
