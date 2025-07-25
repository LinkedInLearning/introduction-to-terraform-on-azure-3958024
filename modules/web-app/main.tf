locals {
  resource_suffix = "${var.environment}-${var.project_name}-webapp"

  common_tags = merge(
    var.tags,
    {
      environment  = var.environment
      project_name = var.project_name
      managed_by   = "terraform"
      module_name  = "webapp"
    }
  )
}

resource "azurerm_resource_group" "webapp" {
  name     = "rg-${local.resource_suffix}"
  location = var.location
  tags     = local.common_tags
}

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "plan-${local.resource_suffix}"
  resource_group_name = azurerm_resource_group.webapp.name
  location            = azurerm_resource_group.webapp.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku
  tags                = local.common_tags
}

# Web App
resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.environment}-${var.project_name}-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.webapp.name
  location            = azurerm_resource_group.webapp.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }

  app_settings = var.database_connection_string != "" ? {
    "DATABASE_CONNECTION_STRING" = var.database_connection_string
  } : {}

  tags = local.common_tags
}

# Random string for unique naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}
