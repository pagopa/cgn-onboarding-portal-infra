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
