variable "location" {
  type = string
}

variable "name" {
  type        = string
  description = "The name of the storage account resource"

  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 24 && can(regex("[a-z0-9]", var.name))
    error_message = "The name can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long."
  }
}

variable "versioning_name" {
  type        = string
  description = "The name of the storage account versioning resource"
}

variable "lock_name" {
  type        = string
  description = "The name of the storage account lock resource"
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "account_kind" {
  type    = string
  default = "StorageV2"
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "access_tier" {
  type = string
}

variable "soft_delete_retention" {
  description = "Number of retention days for soft delete. If set to null it will disable soft delete all together."
  type        = number
  default     = null
}

variable "cors_rule" {
  description = "CORS rules for storage account."
  type = list(object({
    allowed_origins    = list(string)
    allowed_methods    = list(string)
    allowed_headers    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  default = []
}

variable "allow_blob_public_access" {
  description = "Allow or disallow public access to all blobs or containers in the storage account."
  type        = bool
  default     = false
}


# Note: If specifying network_rules, one of either ip_rules or virtual_network_subnet_ids must be specified
# and default_action must be set to Deny.

variable "network_rules" {
  type = object({
    default_action             = string # Valid option Deny Allow
    bypass                     = set(string)
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default = null
}


variable "enable_versioning" {
  type        = bool
  description = "Enable versioning in the blob storage account."
  default     = true
}

variable "lock" {
  type        = bool
  description = "Lock the storage account"
  default     = false
}

variable "lock_scope" {
  type        = string
  description = "Specifies the scope at which the Management Lock should be created. Usually this is the resource id."
  default     = null
}

variable "lock_level" {
  type        = string
  description = "Specifies the scope at which the Management Lock should be created."
  default     = "CanNotDelete"

  validation {
    condition = (
      var.lock_level == "CanNotDelete" ||
      var.lock_level == "ReadOnly"
    )
    error_message = "Lock level can be CanNotDelete or ReadOnly."
  }
}

variable "lock_notes" {
  type        = string
  description = "Specifies some notes about the lock. Maximum of 512 characters"
  default     = null

  validation {
    condition = (
      var.lock_notes != null ? length(var.lock_notes) <= 512 : true
    )
    error_message = "Notes Maximum of 512 characters."
  }

}


# Static website
variable "enable_static_website" {
  description = "Controls if static website to be enabled on the storage account. Possible values are `true` or `false`"
  default     = false
}


variable "index_path" {
  description = "path from your repo root to index.html"
  default     = "index.html"
}

variable "custom_404_path" {
  description = "path from your repo root to your custom 404 page"
  default     = "index.html"
}
