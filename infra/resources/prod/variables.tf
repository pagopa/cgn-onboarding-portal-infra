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

## AD B2C
variable "adb2c_openid_config_url" {
  type        = string
  description = "Azure AD B2C OpenID Connect metadata document"
}

variable "adb2c_audience" {
  type        = string
  description = "recipients that the JWT is intended for"
}

# Network
variable "dns_config" {
  type = object({
    second_level         = string
    external_third_level = string
    internal_third_level = string
    dns_default_ttl_sec  = number
  })

  default = {
    second_level         = "pagopa.it"
    external_third_level = "trial"
    internal_third_level = "internal"
    dns_default_ttl_sec  = 3600
  }
}

variable "subnet_cidr" {
  type    = list(string)
  default = []
}