
resource "tfe_variable" "prod_env_short" {
  key          = "env_short"
  value        = "d"
  category     = "terraform"
  workspace_id = data.tfe_workspace.prod.id
  description  = "Single char for the current environment"
}

resource "tfe_variable" "prod_tags" {
  key          = "tags"
  value        = <<-EOT
  {
    CreatedBy    = "Terraform"
    Environment  = "Prod"
  }
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.prod.id
  description  = "tags for the cloud resources"
}

