variable "tfe_organization_name" {
  type        = string
  description = "The name of the Terraform Cloud Organization"
  default     = "bitrock-pagopa"
}

data "tfe_workspace" "dev" {
  name         = "cgn-onboarding-portal-dev"
  organization = var.tfe_organization_name
}

data "tfe_workspace" "prod" {
  name         = "cgn-onboarding-portal-prod"
  organization = var.tfe_organization_name
}
