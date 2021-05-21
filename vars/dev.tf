
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

resource "tfe_variable" "dev_cidr_subnet_apim" {
  key          = "cidr_subnet_apim"
  value        = <<-EOT
  ["10.0.4.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr virtual apim. CreatedBy Terraform"
}

resource "tfe_variable" "dev_cidr_subnet_spid_login" {
  key          = "cidr_subnet_spid_login"
  value        = <<-EOT
  ["10.0.5.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr virtual spid login. CreatedBy Terraform"
}

resource "tfe_variable" "dev_cidr_subnet_function" {
  key          = "cidr_subnet_function"
  value        = <<-EOT
  ["10.0.6.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr virtual function. CreatedBy Terraform"
}

resource "tfe_variable" "dev_cidr_subnet_ade_aa_mock" {
  key          = "cidr_subnet_ade_aa_mock"
  value        = <<-EOT
  ["10.0.7.0/24"]
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "cidr virtual ade aa mock. CreatedBy Terraform"
}

# DNS
resource "tfe_variable" "dev_external_domain" {
  key          = "external_domain"
  value        = "caravan-azure.bitrock.it"
  hcl          = false
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "DNS External domain. CreatedBy Terraform"
}

resource "tfe_variable" "dev_dns_zone_prefix" {
  key          = "dns_zone_prefix"
  value        = "cgn-dev"
  hcl          = false
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "DNS zone prefix. CreatedBy Terraform"
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

resource "tfe_variable" "dev_enable_sonarqube" {
  key          = "enable_sonarqube"
  value        = "false"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Enable sonarqube resources. CreatedBy Terraform"
}

resource "tfe_variable" "dev_apim_notification_sender_email" {
  key          = "apim_notification_sender_email"
  value        = "cgn-apim@pagopa.it"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Email address from which the notification will be sent. CreatedBy Terraform"
}

resource "tfe_variable" "dev_apim_publisher_name" {
  key          = "apim_publisher_name"
  value        = "CGN Onboarding Portal"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "The name of publisher/company. CreatedBy Terraform"
}

resource "tfe_variable" "dev_apim_publisher_email" {
  key          = "apim_publisher_email"
  value        = "cgn-apim@pagopa.it"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "The email of publisher/company. CreatedBy Terraform"
}


resource "tfe_variable" "dev_redis_cache_family" {
  key          = "redis_cache_family"
  value        = "C"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "The SKU family/pricing group to use. CreatedBy Terraform"
}

resource "tfe_variable" "dev_redis_cache_sku_name" {
  key          = "redis_cache_sku_name"
  value        = "Standard"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "The SKU of Redis to use. CreatedBy Terraform"
}

resource "tfe_variable" "dev_enable_spid_test" {
  key          = "enable_spid_test"
  value        = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Create spid test container group. Default false.  CreatedBy Terraform"
}

resource "tfe_variable" "dev_app_gateway_host_name" {
  key          = "app_gateway_host_name"
  value        = "api.cgn-dev.caravan-azure.bitrock.it"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Application gateway host name. CreatedBy Terraform"
}

resource "tfe_variable" "dev_azure_client_secret" {
  key          = "TF_VAR_azure_client_secret"
  value        = "$ARM_CLIENT_SECRET"
  category     = "env"
  sensitive    = true
  workspace_id = data.tfe_workspace.dev.id
}

resource "tfe_variable" "dev_enable_ade_aa_mock" {
  key          = "enable_ade_aa_mock"
  value        = "true"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
}

resource "tfe_variable" "dev_adb2c_openid_config_url" {
  key          = "adb2c_openid_config_url"
  value        = "https://testcgnportalbitrock.b2clogin.com/testcgnportalbitrock.onmicrosoft.com/B2C_1_LOGIN/v2.0/.well-known/openid-configuration"
  category     = "terraform"
  sensitive    = true
  workspace_id = data.tfe_workspace.dev.id
}

resource "tfe_variable" "dev_adb2c_audience" {
  key          = "adb2c_audience"
  value        = "5f75f12e-b5a0-4656-b0ff-334bb9d4222f"
  category     = "terraform"
  sensitive    = true
  workspace_id = data.tfe_workspace.dev.id
}

resource "tfe_variable" "dev_email_username" {
  key          = "email_username"
  value        = "matteo.gazzetta@bitrock.it"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
}

resource "tfe_variable" "dev_email_department_email" {
  key          = "email_department_email"
  value        = "matteo.gazzetta@bitrock.it"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
}

resource "tfe_variable" "dev_devops_admin_email" {
  key          = "devops_admin_email"
  value        = "matteo.gazzetta@bitrock.it"
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
}

resource "tfe_variable" "dev_db_monitor_metric_alert_criteria" {
  key          = "db_monitor_metric_alert_criteria"
  value        = <<-EOT
{
  cpu = {
    aggregation = "Average"
    metric_name = "cpu_percent"
    operator = "GreaterThanOrEqual"
    threshold = 80
    frequency = "PT5M"
    window_size = "PT30M"
    dimension = {}
  }
  memory = {
    aggregation = "Average"
    metric_name = "memory_percent"
    operator = "GreaterThanOrEqual"
    threshold = 80
    frequency = "PT5M"
    window_size = "PT30M"
    dimension = {}
  }
  io = {
    aggregation = "Average"
    metric_name = "io_consumption_percent"
    operator = "GreaterThanOrEqual"
    threshold = 80
    frequency = "PT5M"
    window_size = "PT30M"
    dimension = {}
  }
  active_connections = {
    aggregation = "Average"
    metric_name = "active_connections"
    operator = "GreaterThanOrEqual"
    threshold = 116
    frequency = "PT5M"
    window_size = "PT5M"
    dimension = {}
  }
}
  EOT
  hcl          = true
  category     = "terraform"
  workspace_id = data.tfe_workspace.dev.id
  description  = "Map of monitor name - criteria objects for DB. CreatedBy Terraform"
}
