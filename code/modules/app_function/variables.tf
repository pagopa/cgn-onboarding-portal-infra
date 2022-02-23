variable "name" {
  description = "Function App Name"
  type        = string
}

variable "slot_name" {
  type        = string
  default     = null
  description = "Function slot name. If null the slot wouldn't be created."
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group_name" {
  type = string
}

variable "runtime_version" {
  type    = string
  default = "~3"
}

variable "os_type" {
  type    = string
  default = "linux"
}

variable "pre_warmed_instance_count" {
  type = number

  default = 1
}

variable "application_insights_instrumentation_key" {
  type = string
}

variable "app_settings" {
  type        = map(any)
  description = "App settings."
  default     = {}
}

variable "app_settings_slot" {
  type        = map(any)
  description = "App settings for the slot function."
  default     = {}
}

variable "allowed_ips" {
  // List of ip
  type    = list(string)
  default = []
}

variable "cors" {
  type = object({
    allowed_origins = list(string)
  })
  default = null
}

variable "allowed_subnets" {
  // List of subnet id
  type    = list(string)
  default = []
}

variable "subnet_name" {
  type = string

  default = null
}

variable "subnet_id" {
  type = string

  default = null
}

variable "health_check_path" {
  type    = string
  default = null
}

variable "health_check_maxpingfailures" {
  type    = number
  default = 10
}

variable "maximum_elastic_worker_count" {
  type        = number
  default     = 1
  description = "The maximum number of total workers allowed for this ElasticScaleEnabled App Service Plan."

}

variable "plan_info" {
  type = object({
    kind     = string
    sku_tier = string
    sku_size = string
    capacity = number
  })

  default = {
    kind     = "elastic"
    sku_tier = "ElasticPremium"
    sku_size = "EP1"
    capacity = 1
  }
}

variable "elastic_instance_minimum" {
  type        = number
  description = "The number of minimum instances for this function app. Only affects apps on the Premium plan."
  default     = 1
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
