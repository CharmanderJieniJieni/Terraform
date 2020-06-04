# storage account for audit logs
resource "azurerm_storage_account" "sql-audit" {
  name                     = var.sql_server_storage_account
  resource_group_name      = var.resource_group_dap_storage
  location                 = var.azure_region
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "container" {
  name                  = var.sql_server_storage_container
  storage_account_name  = azurerm_storage_account.sql-audit.name
  container_access_type = "private"
}

resource "azurerm_sql_server" "sql-server-srv" {
  name                         = var.sql_server_srv_name
  resource_group_name          = var.resource_group_dap_storage
  location                     = var.azure_region
  version                      = "12.0"
  administrator_login          = "abc"
  administrator_login_password = "randome"

  identity {
      type = "SystemAssigned"
  }

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.sql-audit.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.sql-audit.primary_access_key
    storage_account_access_key_is_secondary = false
    retention_in_days                       = 0
  }

  depends_on = [azurerm_storage_account.sql-audit]
}

resource "azurerm_mssql_server_security_alert_policy" "security-alert" {
  resource_group_name        = var.resource_group_dap_storage
  server_name                = azurerm_sql_server.sql-server-srv.name
  state                      = "Enabled"
  #storage_endpoint           = azurerm_storage_account.sql-audit.primary_blob_endpoint
  #storage_account_access_key = azurerm_storage_account.sql-audit.primary_access_key

  retention_days = 20

  depends_on = [azurerm_sql_server.sql-server-srv,azurerm_storage_account.sql-audit]
}

resource "azurerm_mssql_server_vulnerability_assessment" "vulnerability-assessment" {
  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.security-alert.id
  storage_container_path          = "${azurerm_storage_account.sql-audit.primary_blob_endpoint}${azurerm_storage_container.container.name}/"
  storage_account_access_key      = azurerm_storage_account.sql-audit.primary_access_key

  recurring_scans {
    enabled                   = true
    email_subscription_admins = true
    emails = [
      "shiywu@deloitte.ca"
    ]
  }
}