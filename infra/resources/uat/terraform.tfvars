env_short           = "u"
external_domain     = "pagopa.it"
dns_zone_prefix_uat = "cgnonboardingportal-uat"

apim_notification_sender_email = "io-operations@pagopa.it"
apim_publisher_email           = "io-operations@pagopa.it"
apim_publisher_name            = "PagoPa CGN Onboarding Portal"
apim_sku                       = "Developer_1"

adb2c_audience          = "2416d411-9cbb-4d4c-a902-2570f031b9f0"
adb2c_openid_config_url = "https://cgnonboardingportaluat.b2clogin.com/cgnonboardingportaluat.onmicrosoft.com/B2C_1_login/v2.0/.well-known/openid-configuration"

enable_ade_aa_mock = true
enable_custom_dns  = true
enable_spid_test   = true

subnet_cidr = ["10.0.10.0/24"]

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "cgn-onboarding-portal"
  Source      = "github.com/pagopa/cgn-onboarding-portal-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}