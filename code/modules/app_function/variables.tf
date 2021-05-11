variable "name" {
  description = "Function App Name"
  type        = string
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
  type = map(any)

  default = {}
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

variable "sku" {
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

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
