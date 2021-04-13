
resource "tfe_variable" "dev_env_short" {
  key          = "env_short"
  value        = "d"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Single char for the current environment. CreatedBy Terraform"
}

resource "tfe_variable" "dev_tags" {
  key          = "tags"
  value        = <<-EOT
  {
    CreatedBy    = "Terraform"
    Environment  = "Dev"
    Owner        = "cgn-onboarding-portal"
    Repo         = "github.com/pagopa/cgn-onboarding-portal-infra"
  }
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "tags for the cloud resources. CreatedBy Terraform"
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
  description  = "cidr virtual network. CreatedBy Terraform"
}

resource "tfe_variable" "dev_cidr_subnet_db" {
  key          = "cidr_subnet_db"
  value        = <<-EOT
  ["10.0.1.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr subnet db. CreatedBy Terraform"
}

resource "tfe_variable" "dev_cidr_subnet_api" {
  key          = "cidr_subnet_api"
  value        = <<-EOT
  ["10.0.2.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr virtual api. CreatedBy Terraform"
}

resource "tfe_variable" "dev_cidr_subnet_public" {
  key          = "cidr_subnet_public"
  value        = <<-EOT
  ["10.0.3.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr subnet public. CreatedBy Terraform"
}


# Database
resource "tfe_variable" "dev_db_sku_name" {
  key          = "db_sku_name"
  value        = "GP_Gen5_2"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Specifies the SKU Name for this PostgreSQL Server. CreatedBy Terraform"
}

resource "tfe_variable" "dev_db_version" {
  key          = "db_version"
  value        = "11"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Specifies the version of PostgreSQL to use. CreatedBy Terraform"
}

resource "tfe_variable" "dev_database_name" {
  key          = "database_name"
  value        = "cgnonboardingportal"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Name of the database. CreatedBy Terraform"
}