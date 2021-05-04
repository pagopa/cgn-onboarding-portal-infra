
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.52.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 1.4.0"
    }

    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "0.0.6"
    }
  }

  # terraform cloud.
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "PagoPa"
    workspaces {
      prefix = "cgn-onboarding-portal-"
    }
  }
}
provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {
}

locals {
  project = format("%s-%s", var.prefix, var.env_short)
}
