ad_key_vault_group_object_id         = "e938c2d8-663c-4a21-9f55-a24b5d0fb820"
adb2c_audience                       = "2416d411-9cbb-4d4c-a902-2570f031b9f0"
adb2c_openid_config_url              = "https://cgnonboardingportaluat.b2clogin.com/cgnonboardingportaluat.onmicrosoft.com/B2C_1_login/v2.0/.well-known/openid-configuration"
apim_notification_sender_email       = "io-operations@pagopa.it"
apim_publisher_email                 = "io-operations@pagopa.it"
apim_publisher_name                  = "PagoPa CGN Onboarding Portal"
app_gateway_certificate_name         = "api-cgnonboardingportal-uat-pagopa-it"
app_gateway_host_name                = "api.cgnonboardingportal-uat.pagopa.it"
app_gateway_min_capacity             = 0
cert_renew_app_object_id             = "c1f7c025-f1ec-48c5-a9ab-15f9abfbf35d"
cidr_vnet                            = ["10.0.0.0/16"]
cidr_subnet_db                       = ["10.0.1.0/24"]
cidr_subnet_api                      = ["10.0.2.0/24"]
cidr_subnet_public                   = ["10.0.3.0/24"]
cidr_subnet_apim                     = ["10.0.4.0/24"]
cidr_subnet_spid_login               = ["10.0.5.0/24"]
cidr_subnet_function                 = ["10.0.6.0/24"]
cidr_subnet_ade_aa_mock              = ["10.0.7.0/24"]
cidr_subnet_redis                    = ["10.0.8.0/24"]
cidr_subnet_function_operator_search = ["10.0.9.0/24"]
cidr_subnet_dns_forwarder            = ["10.0.134.0/29"]
database_name                        = "cgnonboardingportal-prod-like"
attribute_authority_database_name    = "cgnonboardingportal-attribute-authority"
db_monitor_metric_alert_criteria = {
  cpu = {
    aggregation = "Average"
    metric_name = "cpu_percent"
    operator    = "GreaterThanOrEqual"
    threshold   = 80
    frequency   = "PT5M"
    window_size = "PT30M"
    dimension   = {}
  }
  memory = {
    aggregation = "Average"
    metric_name = "memory_percent"
    operator    = "GreaterThanOrEqual"
    threshold   = 80
    frequency   = "PT5M"
    window_size = "PT30M"
    dimension   = {}
  }
  io = {
    aggregation = "Average"
    metric_name = "io_consumption_percent"
    operator    = "GreaterThanOrEqual"
    threshold   = 80
    frequency   = "PT5M"
    window_size = "PT30M"
    dimension   = {}
  }
  active_connections = {
    aggregation = "Average"
    metric_name = "active_connections"
    operator    = "GreaterThanOrEqual"
    threshold   = 116
    frequency   = "PT5M"
    window_size = "PT5M"
    dimension   = {}
  }
}
db_sku_name                      = "GP_Gen5_2"
db_version                       = 11
db_public_network_access_enabled = true
db_storage_mb                    = 10240
devops_admin_email               = "io-operations@pagopa.it"
dns_zone_prefix_uat              = "cgnonboardingportal-uat"
email_department_email           = "prod-carta-giovani@pagopa.it"
enable_ade_aa_mock               = true
enable_custom_dns                = true
enable_spid_test                 = true
env_short                        = "u"
external_domain                  = "pagopa.it"
pe_min_csv_rows                  = 0
redis_cache_family               = "C"
redis_cache_sku_name             = "Standard"
operator_search_external_allowed_subnets = [
  # io-backend
  "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl1",
  "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl2",
  "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl3",
  "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/apimapi",
  "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/apimv2api",
]
operator_search_allowed_ips = [
  "0.0.0.0/0"
]

eyca_export_enabled = false

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "cgn-onboarding-portal"
  Source      = "github.com/pagopa/cgn-onboarding-portal-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}
