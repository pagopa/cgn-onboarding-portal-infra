
resource "tfe_variable" "dev_env_short" {
  key          = "env_short"
  value        = "d"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Single char for the current environment"
}


resource "tfe_variable" "dev_tags" {
  key          = "tags"
  value        = <<-EOT
  {
    CreateBy    = "Terraform"
    Environment = "Dev"
  }
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "tags for the cloud resources"
}


# Network
resource "tfe_variable" "dev_cidr_vnet" {
  key          = "cidr_vnet"
  value        = <<-EOT
  ["10.0.0.0/16"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr virtual network"
}

resource "tfe_variable" "dev_cidr_subnet_db" {
  key          = "cidr_subnet_db"
  value        = <<-EOT
  ["10.0.1.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr subnet db"
}

resource "tfe_variable" "dev_cidr_subnet_api" {
  key          = "cidr_subnet_api"
  value        = <<-EOT
  ["10.0.2.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr virtual api"
}

resource "tfe_variable" "dev_cidr_subnet_public" {
  key          = "cidr_subnet_public"
  value        = <<-EOT
  ["10.0.3.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr subnet public"
}


