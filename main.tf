terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.75.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = var.storage_resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}



# resource "random_integer" "ri" {
#   min = 10000
#   max = 99999
# }

resource "azurerm_resource_group" "taskBoardRG" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_mssql_server" "task-board-sql" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.taskBoardRG.name
  location                     = azurerm_resource_group.taskBoardRG.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "TaskBoardDB" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.task-board-sql.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = "Basic"
  zone_redundant = false
}

resource "azurerm_service_plan" "service_plan" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.taskBoardRG.name
  location            = azurerm_resource_group.taskBoardRG.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "linux_web_app" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.taskBoardRG.name
  location            = azurerm_service_plan.service_plan.location
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = false
  }

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${azurerm_mssql_server.task-board-sql.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.TaskBoardDB.name};User ID=${azurerm_mssql_server.task-board-sql.administrator_login};Password=${azurerm_mssql_server.task-board-sql.administrator_login_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
  }
}

resource "azurerm_app_service_source_control" "git_repo" {
  app_id                 = azurerm_linux_web_app.linux_web_app.id
  repo_url               = var.repo_Url
  branch                 = "main"
  use_manual_integration = true
}

resource "azurerm_mssql_firewall_rule" "allowAll" {
  name             = var.firewall_rule_name
  server_id        = azurerm_mssql_server.task-board-sql.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}