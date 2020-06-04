variable "resource_group_core" {
  description = "Resource group for dap core"
  type        = string
  default     = "swu-test-terraform"
}

variable "resource_group_dap_storage" {
  description = "Resource group for dap storage"
  type        = string
  default     = "rg-dap-storage-dev-001"
}

variable "dbks-control-plane-nat" {
  description = "NAT IP address for Azure Databricks Control Plane"
  type        = string
  default     = "40.85.223.25/32"
}

variable "dbks-webapp-nat" {
  description = "NAT IP address for Azure Databricks Webapp"
  type        = string
  default     = "13.71.184.74/32"
}

variable "sql_server_srv_name" {
  description = "the name of the sql server"
  type        = string
  default     = "sqlsrv-swu-dev-001"
}

variable "db_create_mode" {
  description = "the create mode of the db"
  type        = string
  default     = "Default"
}

variable "db_edition" {
  description = "the size of the db"
  type        = string
  default     = "Standard"
}

variable "db_collation" {
  description = "the type collation"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "db_service_objective_name" {
  description = "the additional size of the db"
  type        = string
  default     = "S0"
}

variable "db_max_size_bytes" {
  description = "the size of the db"
  type        = string
  default     = "268435456000"
}

variable "log_analytics_workspace" {
  description = "Identifies the log analytics workspace"
  type        = string
  default     = "lgawdap-test002"
}

variable "resource_group_dap_la" {
  description = "Resource group for dap la"
  type        = string
  default     = "rg-test-la-dev"
}

# sql
variable "sql_db_diag_name" {
  description = "Specifies the name of the diagnostic setting for a SQL database"
  default     = "sqldb-diagnostics"
}

# ALLOWED LOCATIONS
variable "azure_region" {
  description = "Region for the resource group"
  type        = string
  default     = "canadacentral"
}


#Map for SQL Databases
variable "sql-database-names-001" {
  description = "Databases required in the SQL PaaS"
  type = map(object({
    db-name = string
  }))
    default = {
        sql-db-1 = { db-name = "test001" }
        sql-db-2 = { db-name = "test002" }
  }
}

variable "sqldb_diag_log" {
  description = "Diagnostic Log categories for SQL databases"
  type        = list(object({ category = string, enabled = bool, retention_policy = object({ enabled = bool })}))
  default = [
    {
      category = "SQLInsights",
      enabled  = true,
      retention_policy = {
        enabled = true
      }
    },
    {
      category = "AutomaticTuning",
      enabled  = true,
      retention_policy = {
        enabled = true
      }
    },
    {
      category = "QueryStoreRuntimeStatistics",
      enabled  = true,
      retention_policy = {
        enabled = true
      }
    },
    {
      category = "QueryStoreWaitStatistics",
      enabled  = true,
      retention_policy = {
        enabled = true
      } 
    },
    {
      category = "Errors",
      enabled  = true,
      retention_policy = {
        enabled = true
      }
    },
    {
      category = "DatabaseWaitStatistics",
      enabled  = true,
      retention_policy = {
        enabled = true
      } 
    },
    {
      category = "Timeouts",
      enabled  = true,
      retention_policy = {
        enabled = true
      }
    },
    {
      category = "Blocks",
      enabled  = true,
      retention_policy = {
        enabled = true
      }
    },
    {
      category = "Deadlocks",
      enabled  = true,
      retention_policy = {
        enabled = true
      }
    }
  ]
}

variable "sqldb_diag_metric" {
  description = "Diagnostic Metric categories for SQL databases"
  type        = list(object({ category = string, enabled = bool, retention_policy = object({ enabled = bool })}))
  default = [
    {
      category = "Basic",
      enabled  = true,
      retention_policy = {
        enabled = true
      }
    },
    {
      category = "InstanceAndAppAdvanced",
      enabled  = true,
      retention_policy = {
        enabled = true
      }
    },
    {
      category = "WorkloadManagement",
      enabled  = true,
      retention_policy = {
        enabled = true
      }
    }
  ]
}

variable "sql_server_storage_account" {
  description = "the name of the storage account for the sql paas audit logs"
  type        = string
  default     = "stsqlaadfsaefswu"
}


variable "sql_server_storage_container" {
  description = "the name of the storage container for sql paas audit logs"
  type        = string
  default     = "sqlsrv-swu-dev-audit"
}