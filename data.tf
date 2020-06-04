data "azurerm_resource_group" "dap_core" {
  name = var.resource_group_dap_core
}

data "azurerm_log_analytics_workspace" "lgawdap-dev" {
  name                = var.log_analytics_workspace
  resource_group_name = data.azurerm_resource_group.loganalytics_rg.name
}

# Log Analytics
data "azurerm_resource_group" "loganalytics_rg" {
  name                = var.resource_group_dap_la
}