ad_key_vault_group_object_id   = "e938c2d8-663c-4a21-9f55-a24b5d0fb820"
adb2c_audience                 = "45755efd-fd5a-4e92-99d1-e59e40b1c97e"
adb2c_openid_config_url        = "https://cgnonboardingportal.b2clogin.com/cgnonboardingportal.onmicrosoft.com/B2C_1_login/v2.0/.well-known/openid-configuration"
agid_spid_private_key          = "AGID-SPID-CERT-KEY"
agid_spid_public_cert          = "AGID-SPID-CERT-PEM"
apim_notification_sender_email = "io-operations@pagopa.it"
apim_publisher_email           = "io-operations@pagopa.it"
apim_publisher_name            = "PagoPa CGN Onboarding Portal"
app_gateway_certificate_name   = "api-cgnonboardingportal-pagopa-it"
app_gateway_alerts_enabled     = true
app_gateway_host_name          = "api.cgnonboardingportal.pagopa.it"
app_gateway_sku_name           = "WAF_v2"
app_gateway_sku_tier           = "WAF_v2"
backend_sku = {
  tier     = "PremiumV3"
  size     = "P1v3"
  capacity = 1
}
db_storage_mb             = 204800 # 100 GB => ~ 300 IOPS
cert_renew_app_object_id  = "89d45b50-21e3-4cf0-b39f-9394022a44a6"
cidr_vnet                 = ["10.0.0.0/16"]
cidr_subnet_db            = ["10.0.1.0/24"]
cidr_subnet_api           = ["10.0.2.0/24"]
cidr_subnet_public        = ["10.0.3.0/24"]
cidr_subnet_apim          = ["10.0.4.0/24"]
cidr_subnet_spid_login    = ["10.0.5.0/24"]
cidr_subnet_function      = ["10.0.6.0/24"]
cidr_subnet_ade_aa_mock   = ["10.0.7.0/24"]
cidr_subnet_redis         = ["10.0.8.0/24"]
cidr_subnet_vpn           = ["10.0.133.0/24"]
cidr_subnet_dns_forwarder = ["10.0.134.0/29"]

database_name                     = "cgnonboardingportal"
attribute_authority_database_name = "cgnonboardingportal-attribute-authority"
db_sku_name                       = "GP_Gen5_4"
db_version                        = 11
devops_admin_email                = "io-operations@pagopa.it"
dns_zone_prefix                   = "cgnonboardingportal"
email_department_email            = "cartagiovaninazionale@governo.it"
enable_ade_aa_mock                = true
enable_custom_dns                 = true
enable_spid_test                  = false
env_short                         = "p"
external_domain                   = "pagopa.it"
io_apim_resourcegroup             = "io-p-rg-internal"
io_apim_name                      = "io-p-apim-api"
io_apim_productid                 = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.ApiManagement/service/io-p-apim-api/products/cgnmerchant"
io_apim_subscription_id           = "ec285037-c673-4f58-b594-d7c480da4e8b"
redis_cache_family                = "C"
redis_cache_sku_name              = "Standard"
operator_search_capacity          = 1
operator_search_external_allowed_subnets = [
  # io-backend
  "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl1",
  "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/appbackendl2",
  # io apim
  "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/apimapi",
]
operator_search_elastic_instance_minimum     = 1
operator_search_maximum_elastic_worker_count = 30

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "cgn-onboarding-portal"
  Source      = "github.com/pagopa/cgn-onboarding-portal-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}
