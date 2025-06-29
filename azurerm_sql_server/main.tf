data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "secret" {
  name         = var.secret_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "sql_password" {
  name         = var.secret_pass
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_name
  resource_group_name          = var.resource_group_name
  location                     = var.sqlserver_location
  version                      = var.sql_serverversion
  administrator_login          = data.azurerm_key_vault_secret.secret.name
  administrator_login_password = data.azurerm_key_vault_secret.sql_password.value
  public_network_access_enabled    = false
  minimum_tls_version = "1.2"
}

data "azurerm_storage_account" "audit_storage" {
  name                = var.storage_name
  resource_group_name = var.resource_group_name
}

variable "storage_name" {
  type = string
}


resource "azurerm_mssql_server_extended_auditing_policy" "sql_server_audit" {
  server_id            = azurerm_mssql_server.sql_server.id
  storage_endpoint     = data.azurerm_storage_account.audit_storage.primary_blob_endpoint
  storage_account_access_key = data.azurerm_storage_account.audit_storage.primary_access_key
  retention_in_days    = 90
}

