# Generate random suffix for globally unique names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

locals {
  resource_suffix = "${var.environment}-${var.project_name}-database"

  common_tags = merge(
    var.tags,
    {
      environment  = var.environment
      project_name = var.project_name
      managed_by   = "terraform"
      module_name  = "database"
    }
  )
}

resource "azurerm_resource_group" "database" {
  name     = "rg-${local.resource_suffix}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_mssql_server" "main" {
  name                         = "sql-${var.environment}-${var.project_name}-${random_string.suffix.result}"
  resource_group_name          = azurerm_resource_group.database.name
  location                     = azurerm_resource_group.database.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  tags                         = local.common_tags
}

resource "azurerm_mssql_database" "main" {
  name      = "db-${var.environment}-${var.project_name}"
  server_id = azurerm_mssql_server.main.id
  sku_name  = var.database_sku
  tags      = local.common_tags
}

#Firewall rule to allow Azure services
resource "azurerm_mssql_firewall_rule" "azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
