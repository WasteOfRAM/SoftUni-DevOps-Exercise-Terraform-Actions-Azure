resource_group_name         = "TaskBoardRG-14"
resource_group_location     = "West Europe"
app_service_plan_name       = "task-board-plan-14"
app_service_name            = "task-board-14"
sql_server_name             = "task-board-sql-14"
sql_database_name           = "TaskBoardDB-14"
sql_admin_login             = "${secrets.SQL_ADMIN_LOGIN}"
sql_admin_password          = "${secrets.SQL_ADMIN_PASSWORD}"
firewall_rule_name          = "TaskBoardFirewallRule-AllowAll"
repo_Url                    = "https://github.com/WasteOfRAM/SoftUni-DevOps-Terraform-Exercise-WebApp"
storage_resource_group_name = "StorageRG-14"
storage_account_name        = "taskboardstorage-14"
container_name              = "taskboardcontainer-14"