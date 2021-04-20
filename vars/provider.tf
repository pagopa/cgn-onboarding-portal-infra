terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.24.0"
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

provider "tfe" {
  # Configuration options
  # export TFE_TOKEN
}
