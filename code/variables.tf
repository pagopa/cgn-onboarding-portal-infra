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

variable "app_gateway_host_name" {
  type        = string
  description = "Application gateway host name"
}

variable "app_gateway_certificate_name" {
  type        = string
  description = "Application gateway certificate name on Key Vault"
  default     = null
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

variable "cidr_subnet_ade_aa_mock" {
  type    = list(string)
  default = null
}

variable "cidr_subnet_function" {
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

# TODO
# these _uat are a temponary resources
variable "dns_zone_prefix_uat" {
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

variable "devops_admin_email" {
  type        = string
  description = "DevOps email address for alerts notification"
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


variable "db_monitor_metric_alert_criteria" {
  default = {}

  description = <<EOD
Map of name = criteria objects, see these docs for options
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftdbforpostgresqlservers
https://docs.microsoft.com/en-us/azure/postgresql/concepts-limits#maximum-connections
EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    metric_name = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
    frequency = string
    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
    window_size = string

    dimension = map(object({
      name     = string
      operator = string
      values   = list(string)
    }))
  }))
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

# Key vault
variable "cert_renew_app_object_id" {
  type        = string
  description = "Object id of the azure devops app responsible to create and renew tsl certificates."
  default     = null
}

variable "cert_renew_app_id" {
  type        = string
  description = "Application id of the azure devops app responsible to create and renew tsl certificates."
  default     = null
}

variable "ad_key_vault_group_object_id" {
  type        = string
  description = "Active directory object id group that can access key vault."
}

variable "agid_spid_public_cert" {
  type        = string
  description = "Secret name with agid spid public cert file content in pem format"
  default     = null
}

variable "agid_spid_private_key" {
  type        = string
  description = "Secret name with agid spid pricate key file content in pem format"
  default     = null
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

# ADE
variable "enable_ade_aa_mock" {
  type    = bool
  default = false
}

variable "ade_aa_mock_sku" {
  type = object({
    tier     = string
    size     = string
    capacity = number
  })
  default = {
    tier     = "Standard"
    size     = "S1"
    capacity = 1
  }
}

# BACKEND
variable "backend_sku" {
  type = object({
    tier     = string
    size     = string
    capacity = number
  })
  default = {
    tier     = "Standard"
    size     = "S1"
    capacity = 1
  }
}

# HUB SPID LOGIN
variable "hub_spid_login_sku" {
  type = object({
    tier     = string
    size     = string
    capacity = number
  })
  default = {
    tier     = "Standard"
    size     = "S1"
    capacity = 1
  }
}

## AD B2C
variable "adb2c_openid_config_url" {
  type        = string
  description = "Azure AD B2C OpenID Connect metadata document"
}

variable "adb2c_audience" {
  type        = string
  description = "recipients that the JWT is intended for"
}

## Email
variable "email_host" {
  type        = string
  description = "email server hostname"
  default     = "fast.smtpok.com"
}

variable "email_port" {
  type        = number
  description = "email server port"
  default     = 80
}

variable "email_username" {
  type = string
}

variable "email_password" {
  type      = string
  sensitive = true
}

variable "email_department_email" {
  type        = string
  description = "Receipent email address of the CGN Onboarding Department"
}

# API TOKEN
variable "io_apim_resourcegroup" {
  type    = string
  default = null
}

variable "io_apim_name" {
  type    = string
  default = null
}

variable "io_apim_productid" {
  type    = string
  default = null
}

# Recaptcha
variable "recaptcha_secret_key" {
  type      = string
  sensitive = true
}
