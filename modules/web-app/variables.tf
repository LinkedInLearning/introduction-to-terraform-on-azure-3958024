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

variable "app_service_sku" {
  description = "App service plan sku"
  type        = string
  default     = "F1"
}

variable "database_connection_string" {
  description = "Database connection string"
  type        = string
  sensitive   = true
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
