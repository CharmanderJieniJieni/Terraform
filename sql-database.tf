# the sql database to be deployed on the server
resource "azurerm_sql_database" "sql-server-db-001" {
  for_each              = var.sql-database-names-001
  name                              = lower(join("_", tolist(["test"]), list(each.value["db-name"])))
  resource_group_name               = var.resource_group_dap_storage
  location                          = var.azure_region
  server_name                       = var.sql_server_srv_name
  collation                         = var.db_collation
  create_mode                       = var.db_create_mode
  edition                           = var.db_edition
  requested_service_objective_name  = var.db_service_objective_name
  max_size_bytes                    = var.db_max_size_bytes
 
  threat_detection_policy {
     state                      = "Enabled"
     email_addresses = [
      "shiywu@deloitte.ca"
     ]
     retention_days             = "30"
     use_server_default         = "enabled"
  }


  depends_on = [azurerm_sql_server.sql-server-srv]
}

# Enable Diagnostic Settings for SQL databases
resource "azurerm_monitor_diagnostic_setting" "sqldb-diag" {
  for_each              = var.sql-database-names-001
  name                       = var.sql_db_diag_name
  target_resource_id         = tostring(azurerm_sql_database.sql-server-db-001[each.key].id)
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.lgawdap-dev.id

  dynamic "log" {
    for_each = var.sqldb_diag_log
    content {
      category = log.value.category
      enabled = log.value.enabled
      retention_policy {
        enabled = log.value.retention_policy.enabled
      } 
    }
  }
  dynamic "metric" {
    for_each = var.sqldb_diag_metric
    content {
      category = metric.value.category
      enabled = metric.value.enabled
      retention_policy {
        enabled = metric.value.retention_policy.enabled
      } 
    }
  }
 depends_on = [azurerm_sql_database.sql-server-db-001]
}
