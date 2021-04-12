variable "name" {
  type        = string
  description = "App service instance name"
}

variable "plan_name" {
  type        = string
  description = "Name of the service plan"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group_name" {
  type = string
}

variable "app_settings" {
  type    = map(string)
  default = {}
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

variable "always_on" {
  type        = bool
  default     = false
  description = "Should the app be loaded at all times?"

}

variable "linux_fx_version" {
  type        = string
  description = " Linux App Framework and version for the App Service."
  default     = null
}

variable "app_command_line" {
  type        = string
  description = "App command line to launch"
  default     = null

}

variable "health_check_path" {
  type        = string
  description = "The health check path to be pinged by App Service."
  default     = null
}

variable "allowed_subnets" {
  type        = list(string)
  description = "List of subnet allowed to call the appserver endpoint."
  default     = []
}

variable "allowed_ips" {
  type        = list(string)
  description = "List of ips allowed to call the appserver endpoint."
  default     = []
}

variable "subnet_id" {
  type        = string
  description = "Subnet id wether you want to integrate the app service to a subnet."
  default     = null

}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
