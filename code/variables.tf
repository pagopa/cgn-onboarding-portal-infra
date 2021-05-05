variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "cgnonboardingportal"
}

variable "env_short" {
  type = string
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

variable "azure_client_secret" {
  description = "AZURE_CLIENT_SECRET"
  default     = null
  sensitive   = true
}

# Apim

variable "apim_private_domain" {
  type    = string
  default = "api.cgnonboardingportal.pagopa.it"
}

variable "apim_name" {
  type    = string
  default = null
}

variable "apim_sku" {
  type    = string
  default = "Developer_1"
}

variable "apim_publisher_name" {
  type = string
}
variable "apim_publisher_email" {
  type = string
}
variable "apim_notification_sender_email" {
  type = string
}

# App Gateway
variable "app_gateway_min_capacity" {
  type    = number
  default = 1
}
variable "app_gateway_max_capacity" {
  type    = number
  default = 2
}

# Network
variable "cidr_vnet" {
  type = list(string)
}

variable "cidr_subnet_db" {
  type = list(string)
}

variable "cidr_subnet_api" {
  type = list(string)
}

variable "cidr_subnet_public" {
  type = list(string)
}

variable "cidr_subnet_apim" {
  type = list(string)
}

variable "cidr_subnet_spid_login" {
  type = list(string)
}

## DNS
variable "enable_custom_dns" {
  type    = bool
  default = false
}

variable "external_domain" {
  type    = string
  default = null
}

variable "dns_zone_prefix" {
  type    = string
  default = null
}

## Azure container registry
variable "sku_container_registry" {
  type    = string
  default = "Basic"
}

variable "retention_policy_acr" {
  type = object({
    days    = number
    enabled = bool
  })
  default = {
    days    = 7
    enabled = true
  }
  description = "Container registry retention policy."
}

## Monitor
variable "law_sku" {
  type        = string
  description = "Sku of the Log Analytics Workspace"
  default     = "PerGB2018"
}

variable "law_retention_in_days" {
  type        = number
  description = "The workspace data retention in days"
  default     = 30
}

variable "law_daily_quota_gb" {
  type        = number
  description = "The workspace daily quota for ingestion in GB."
  default     = -1
}

# postgresql
variable "db_administrator_login" {
  type        = string
  description = "The Administrator Login for the PostgreSQL Server."
  sensitive   = true
}

variable "db_administrator_login_password" {
  type        = string
  description = "The Password associated with the administrator_login."
  sensitive   = true
}

variable "db_sku_name" {
  type        = string
  description = "Specifies the SKU Name for this PostgreSQL Server."
}

variable "db_version" {
  type        = string
  description = "Specifies the version of PostgreSQL to use."
}

variable "db_auto_grow_enabled" {
  type        = bool
  description = " Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload."
  default     = true
}

variable "db_backup_retention_days" {
  type        = number
  description = "Backup retention days for the server"
  default     = null
}

variable "db_create_mode" {
  type        = string
  description = "The creation mode. Can be used to restore or replicate existing servers."
  default     = "Default"
}

variable "db_public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this server."
  default     = false
}

variable "db_ssl_enforcement_enabled" {
  type        = bool
  description = "Specifies if SSL should be enforced on connections."
  default     = true
}

variable "db_ssl_minimal_tls_version_enforced" {
  type        = string
  description = "The mimimun TLS version to support on the sever."
  default     = "TLS1_2"
}

variable "db_storage_mb" {
  type        = number
  description = " Max storage allowed for a server."
  default     = 5120 # 5GB
}

variable "database_name" {
  type        = string
  description = "Name of the database."
}

variable "db_charset" {
  type        = string
  description = "Specifies the Charset for the PostgreSQL Database"
  default     = "UTF8"
}

variable "db_collation" {
  type        = string
  description = "Specifies the Collation for the PostgreSQL Database."
  default     = "Italian_Italy.1252"
}

# storage
variable "storage_account_versioning" {
  type        = bool
  description = "Enable versioning in the blob storage account."
  default     = true
}

variable "storage_account_lock" {
  type = object({
    lock_level = string
    notes      = string
    scope      = string
  })
  default = null
}

variable "storage_account_website_lock" {
  type = object({
    lock_level = string
    notes      = string
    scope      = string
  })
  default = null
}

# Sonarqube
variable "enable_sonarqube" {
  default     = false
  description = "Enable sonarqube resources"
}

variable "ad_key_vault_group_object_id" {
  type        = string
  description = "Active directory object id group that can access key vault."

}

# Redis Cache

variable "redis_cache_family" {
  type        = string
  description = "The SKU family/pricing group to use."
}

variable "redis_cache_sku_name" {
  type        = string
  description = "The SKU of Redis to use."
}

## Spit test
variable "enable_spid_test" {
  type        = bool
  description = "Create spid test container group. Default false"
  default     = false
}
