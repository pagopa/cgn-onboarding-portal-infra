
resource "tfe_variable" "dev_env_short" {
  key          = "env_short"
  value        = "d"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Single char for the current environment"
}
