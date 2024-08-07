
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.87.0, < 3.0.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.0"
    }

    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "0.0.7"
    }
  }

  backend "azurerm" {}
}
provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "Prod-Sec"
  subscription_id = local.sec_sub_id
  features {}
}

data "azurerm_subscription" "current" {
}

locals {
  project = format("%s-%s", var.prefix, var.env_short)
}
