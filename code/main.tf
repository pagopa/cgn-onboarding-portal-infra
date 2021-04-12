
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.52.0"
    }
  }

  # terraform cloud.
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "bitrock-pagopa"
    workspaces {
      prefix = "cgn-onboarding-portal-"
    }
  }
}
provider "azurerm" {
  features {}
}

locals {
  project = format("%s-%s", var.prefix, var.env_short)
}
