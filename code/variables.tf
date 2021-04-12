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
