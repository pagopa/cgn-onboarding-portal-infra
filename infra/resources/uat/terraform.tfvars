adb2c_audience                       = "2416d411-9cbb-4d4c-a902-2570f031b9f0"
adb2c_openid_config_url              = "https://cgnonboardingportaluat.b2clogin.com/cgnonboardingportaluat.onmicrosoft.com/B2C_1_login/v2.0/.well-known/openid-configuration"
apim_notification_sender_email       = "io-operations@pagopa.it"
apim_publisher_email                 = "io-operations@pagopa.it"
apim_publisher_name                  = "PagoPa CGN Onboarding Portal"
database_name                        = "cgnonboardingportal-prod-like"
email_department_email           = "prod-carta-giovani@pagopa.it"
enable_ade_aa_mock               = true
enable_custom_dns                = true
enable_spid_test                 = true
env_short                        = "u"
external_domain                  = "pagopa.it"
pe_min_csv_rows                  = 0
dns_zone_prefix_uat              = "cgnonboardingportal-uat"

eyca_export_enabled = false

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "cgn-onboarding-portal"
  Source      = "github.com/pagopa/cgn-onboarding-portal-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}
