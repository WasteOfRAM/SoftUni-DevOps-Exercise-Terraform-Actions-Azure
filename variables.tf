variable "resource_group_name" {
  type        = string
  description = "Resource group name in Azure"
}

variable "resource_group_location" {
  type        = string
  description = "Resource group location"
}

variable "app_service_plan_name" {
  type        = string
  description = "Azure app service plan name"
}

variable "app_service_name" {
  type        = string
  description = "Azure app service name"
}

variable "sql_server_name" {
  type        = string
  description = "Azure SQL server name"
}

variable "sql_database_name" {
  type        = string
  description = "SQL database name"
}

variable "sql_admin_login" {
  type        = string
  description = "DB admin username"
}

variable "sql_admin_password" {
  type        = string
  description = "DB admin password"
  sensitive   = true
}

variable "firewall_rule_name" {
  type        = string
  description = "Firewall rule name"
}

variable "repo_Url" {
  type        = string
  description = "Git repo URL"
}

variable "storage_resource_group_name" {
  type        = string
  description = "Resource group name in Azure for storage account"
}

variable "storage_account_name" {
  type        = string
  description = "Storage Account name"
}

variable "container_name" {
  type        = string
  description = "Container name"
}