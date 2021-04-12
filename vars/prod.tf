
resource "tfe_variable" "prod_env_short" {
  key          = "env_short"
  value        = "d"
  category     = "terraform"
  workspace_id = data.tfe_workspace.prod.id
  description  = "Single char for the current environment"
}
