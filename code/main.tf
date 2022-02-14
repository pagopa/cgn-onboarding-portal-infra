
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
      version = "0.0.6"
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

  sec_workspace_id = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_workspace_id[0].value : null
  sec_sub_id       = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_sub_id[0].value : null
  sec_storage_id   = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_storage_id[0].value : null
}
