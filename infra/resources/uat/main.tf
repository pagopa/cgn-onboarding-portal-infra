terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.111.0"
    }

    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = ">= 0.2.5"
    }
  }

  backend "azurerm" {
    resource_group_name  = "cgnonboardingportal-u-terraform-rg"
    storage_account_name = "cgnonboardingportalutf"
    container_name       = "tfstate"
    key                  = "cgn.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}
