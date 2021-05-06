
resource "tfe_variable" "prod_env_short" {
  key          = "env_short"
  value        = "d"
  category     = "terraform"
  workspace_id = data.tfe_workspace.prod.id
  description  = "Single char for the current environment. CreatedBy Terraform"
}

resource "tfe_variable" "prod_tags" {
  key          = "tags"
  value        = <<-EOT
  {
    CreatedBy    = "Terraform"
    Environment  = "Prod"
    Owner        = "cgn-onboarding-portal"
    Repo         = "github.com/pagopa/cgn-onboarding-portal-infra"
  }
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.prod.id
  description  = "tags for the cloud resources. CreatedBy Terraform"
}

resource "tfe_variable" "prod_enable_spid_test" {
  key          = "enable_spid_test"
  value        = false
  category     = "terraform"
  workspace_id = data.tfe_workspace.prod.id
  description  = "Create spid test container group. Default false. CreatedBy Terraform"
}

resource "tfe_variable" "prod_app_gateway_host_name" {
  key          = "app_gateway_host_name"
  value        = "XXXXXX"
  category     = "terraform"
  workspace_id = data.tfe_workspace.prod.id
  description  = "Application gateway host name. CreatedBy Terraform"
}

resource "tfe_variable" "prod_app_gateway_certificate_name" {
  key          = "app_gateway_certificate_name"
  value        = "XXXXXXX"
  category     = "terraform"
  workspace_id = data.tfe_workspace.prod.id
  description  = "Application gateway certificate name on Key Vault. CreatedBy Terraform"
}

resource "tfe_variable" "prod_azure_client_secret" {
  key          = "TF_VAR_azure_client_secret"
  value        = "$ARM_CLIENT_SECRET"
  category     = "env"
  sensitive    = true
  workspace_id = data.tfe_workspace.prod.id
}
