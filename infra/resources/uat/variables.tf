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

# Apim

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

## DNS
variable "enable_custom_dns" {
  type    = bool
  default = false
}

variable "dns_zone_prefix" {
  type    = string
  default = null
}

variable "dns_zone_prefix_uat" {
  type    = string
  default = null
}

variable "external_domain" {
  type    = string
  default = null
}

# postgresql

variable "database_name" {
  type        = string
  description = "Name of the database."
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

variable "email_department_email" {
  type        = string
  description = "Receipent email address of the CGN Onboarding Department"
}

# API TOKEN
variable "io_apim_resourcegroup" {
  type    = string
  default = null
}

variable "io_apim_v2_name" {
  type    = string
  default = null
}

variable "io_apim_v2_productid" {
  type    = string
  default = null
}

variable "io_apim_subscription_id" {
  type        = string
  description = "IO apim subscription id. If null the current subscription will be used."
  default     = null
}

# Bucket vars
variable "pe_min_csv_rows" {
  type    = number
  default = 10000
}

# operator_search vars

variable "eyca_export_enabled" {
  type        = bool
  description = "Is eyca export enabled? Default false"
  default     = false
}
