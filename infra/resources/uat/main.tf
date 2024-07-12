terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.111.0"
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
