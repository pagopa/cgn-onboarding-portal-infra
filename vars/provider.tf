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
      name = "cgn-onboarding-portal-vars"
    }
  }
}

provider "tfe" {
  # Configuration options
  # export TFE_TOKEN
}
