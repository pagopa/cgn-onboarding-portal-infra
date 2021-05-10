
resource "tfe_variable" "uat_env_short" {
  key          = "env_short"
  value        = "u"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "Single char for the current environment. CreatedBy Terraform"
}

resource "tfe_variable" "uat_tags" {
  key          = "tags"
  value        = <<-EOT
  {
    CreatedBy    = "Terraform"
    Environment  = "Uat"
    Owner        = "cgn-onboarding-portal"
    Repo         = "github.com/pagopa/cgn-onboarding-portal-infra"
  }
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "tags for the cloud resources. CreatedBy Terraform"
}

# Network
resource "tfe_variable" "uat_cidr_vnet" {
  key          = "cidr_vnet"
  value        = <<-EOT
  ["10.0.0.0/16"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "cidr virtual network. CreatedBy Terraform"
}

resource "tfe_variable" "uat_cidr_subnet_db" {
  key          = "cidr_subnet_db"
  value        = <<-EOT
  ["10.0.1.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "cidr subnet db. CreatedBy Terraform"
}

resource "tfe_variable" "uat_cidr_subnet_api" {
  key          = "cidr_subnet_api"
  value        = <<-EOT
  ["10.0.2.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "cidr virtual api. CreatedBy Terraform"
}

resource "tfe_variable" "uat_cidr_subnet_public" {
  key          = "cidr_subnet_public"
  value        = <<-EOT
  ["10.0.3.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "cidr subnet public. CreatedBy Terraform"
}

resource "tfe_variable" "uat_cidr_subnet_apim" {
  key          = "cidr_subnet_apim"
  value        = <<-EOT
  ["10.0.4.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "cidr virtual apim. CreatedBy Terraform"
}

# DNS
resource "tfe_variable" "uat_external_domain" {
  key          = "external_domain"
  value        = "pagopa.it"
  hcl          = false
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "DNS External domain. CreatedBy Terraform"
}

resource "tfe_variable" "uat_enable_custom_dns" {
  key          = "enable_custom_dns"
  value        = true
  hcl          = false
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "Enable custom domain. CreatedBy Terraform"
}

resource "tfe_variable" "uat_app_gateway_host_name" {
  key          = "app_gateway_host_name"
  value        = "uat.cgnonboardingportal.pagopa.it"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "Application gateway host name. CreatedBy Terraform"
}

resource "tfe_variable" "uat_dns_zone_prefix" {
  key          = "dns_zone_prefix"
  value        = "cgn-uat"
  hcl          = false
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "DNS zone prefix. CreatedBy Terraform"
}

# Database
resource "tfe_variable" "uat_db_sku_name" {
  key          = "db_sku_name"
  value        = "GP_Gen5_2"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "Specifies the SKU Name for this PostgreSQL Server. CreatedBy Terraform"
}

resource "tfe_variable" "uat_db_version" {
  key          = "db_version"
  value        = "11"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "Specifies the version of PostgreSQL to use. CreatedBy Terraform"
}

resource "tfe_variable" "uat_database_name" {
  key          = "database_name"
  value        = "cgnonboardingportal"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "Name of the database. CreatedBy Terraform"
}

resource "tfe_variable" "uat_enable_sonarqube" {
  key          = "enable_sonarqube"
  value        = "false"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "Enable sonarqube resources. CreatedBy Terraform"
}

resource "tfe_variable" "uat_apim_notification_sender_email" {
  key          = "apim_notification_sender_email"
  value        = "cgn-apim@pagopa.it"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "Email address from which the notification will be sent. CreatedBy Terraform"
}

resource "tfe_variable" "uat_apim_publisher_name" {
  key          = "apim_publisher_name"
  value        = "CGN Onboarding Portal"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "The name of publisher/company. CreatedBy Terraform"
}

resource "tfe_variable" "uat_apim_publisher_email" {
  key          = "apim_publisher_email"
  value        = "cgn-apim@pagopa.it"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "The email of publisher/company. CreatedBy Terraform"
}

resource "tfe_variable" "uat_redis_cache_family" {
  key          = "redis_cache_family"
  value        = "C"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "The SKU family/pricing group to use. CreatedBy Terraform"
}

resource "tfe_variable" "uat_redis_cache_sku_name" {
  key          = "redis_cache_sku_name"
  value        = "Standard"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "The SKU of Redis to use. CreatedBy Terraform"
}

resource "tfe_variable" "uat_enable_spid_test" {
  key          = "enable_spid_test"
  value        = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "Create spid test container group. Default false. CreatedBy Terraform"
}

resource "tfe_variable" "uat_app_gateway_certificate_name" {
  key          = "app_gateway_certificate_name"
  value        = "XXXXXXXXX"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  description  = "Application gateway certificate name on Key Vault. CreatedBy Terraform"
}

resource "tfe_variable" "uat_cert_renew_app_object_id" {
  key          = "cert_renew_app_object_id"
  value        = "XXX"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  sensitive    = true
  description  = "Object id of the azure devops app responsible to create and renew tsl certificates. CreatedBy Terraform"
}

resource "tfe_variable" "uat_cert_renew_app_id" {
  key          = "cert_renew_app_id"
  value        = "XXX"
  category     = "terraform"
  workspace_id = data.tfe_workspace.uat.id
  sensitive    = true
  description  = "Application id of the azure devops app responsible to create and renew tsl certificates. CreatedBy Terraform"
}