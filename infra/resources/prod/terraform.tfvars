adb2c_audience                 = "45755efd-fd5a-4e92-99d1-e59e40b1c97e"
adb2c_openid_config_url        = "https://cgnonboardingportal.b2clogin.com/cgnonboardingportal.onmicrosoft.com/B2C_1_login/v2.0/.well-known/openid-configuration"
apim_notification_sender_email = "io-operations@pagopa.it"
apim_publisher_email           = "io-operations@pagopa.it"
apim_publisher_name            = "PagoPa CGN Onboarding Portal"

dns_zone_prefix    = "cgnonboardingportal"
enable_ade_aa_mock = true
enable_custom_dns  = true
enable_spid_test   = false
env_short          = "p"
external_domain    = "pagopa.it"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "cgn-onboarding-portal"
  Source      = "github.com/pagopa/cgn-onboarding-portal-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}
