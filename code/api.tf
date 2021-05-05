resource "azurerm_resource_group" "rg_api" {
  name     = format("%s-api-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_container_registry" "container_registry" {
  name                = join("", [replace(var.prefix, "-", ""), var.env_short, "arc"])
  resource_group_name = azurerm_resource_group.rg_api.name
  location            = azurerm_resource_group.rg_api.location
  sku                 = var.sku_container_registry
  admin_enabled       = true


  dynamic "retention_policy" {
    for_each = var.sku_container_registry == "Premium" ? [var.retention_policy_acr] : []
    content {
      days    = retention_policy.value["days"]
      enabled = retention_policy.value["enabled"]
    }
  }

  tags = var.tags
}

// Require roleAssignments/write auth could be used instead of acr admin user
//resource "azurerm_role_assignment" "app_service_container_registry" {
//  scope                            = azurerm_container_registry.container_registry.id
//  role_definition_name             = "AcrPull"
//  principal_id                     = module.portal_backend_1.principal_id
//  skip_service_principal_aad_check = true
//}


module "portal_backend_1" {
  source = "./modules/app_service"

  name                = format("%s-portal-backend1", local.project)
  plan_name           = format("%s-plan-portal-backend1", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name

  health_check_path = "/actuator/health"

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080

    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.container_registry.admin_password

    # DNS configuration to use private endpoint
    WEBSITE_DNS_SERVER     = "168.63.129.16"
    WEBSITE_VNET_ROUTE_ALL = 1

    # These are app specific environment variables
    SPRING_PROFILES_ACTIVE     = "prod"
    SERVER_PORT                = 8080
    SPRING_DATASOURCE_URL      = format("jdbc:postgresql://%s:5432/%s?%s", trimsuffix(azurerm_private_dns_a_record.private_dns_a_record_postgresql.fqdn, "."), var.database_name, "sslmode=require")
    SPRING_DATASOURCE_USERNAME = format("%s@%s", var.db_administrator_login, azurerm_postgresql_server.postgresql_server.name)
    SPRING_DATASOURCE_PASSWORD = var.db_administrator_login_password
    JAVA_OPTS                  = "-XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication"

    # Blob Storage Account
    CGN_PE_STORAGE_AZURE_DEFAULT_ENDPOINTS_PROTOCOL = "https"
    CGN_PE_STORAGE_AZURE_ACCOUNT_NAME               = module.storage_account.name
    CGN_PE_STORAGE_AZURE_ACCOUNT_KEY                = module.storage_account.primary_access_key
    CGN_PE_STORAGE_AZURE_BLOB_ENDPOINT              = module.storage_account.primary_blob_endpoint
    CGN_PE_STORAGE_AZURE_DOCUMENTS_CONTAINER_NAME   = azurerm_storage_container.user_documents.name
    CGN_PE_STORAGE_AZURE_IMAGED_CONTAINER_NAME      = azurerm_storage_container.profile_images.name

    # application insights
    APPLICATIONINSIGHTS_CONNECTION_STRING = format("InstrumentationKey=%s",
    azurerm_application_insights.application_insights.instrumentation_key)

  }

  linux_fx_version = format("DOCKER|%s/cgn-onboarding-portal-backend:%s",
  azurerm_container_registry.container_registry.login_server, "latest")
  always_on = "true"

  allowed_subnets = [azurerm_subnet.subnet_apim.id]
  allowed_ips     = []

  subnet_name = module.subnet_api.name
  subnet_id   = module.subnet_api.id

  tags = var.tags
}

############################
## App service spid login ##
############################
module "spid_login" {
  source = "./modules/app_service"

  name                = format("%s-spid-login", local.project)
  plan_name           = format("%s-plan-spid-login", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080

    WEBSITE_NODE_DEFAULT_VERSION = "12.18.0"
    WEBSITE_RUN_FROM_PACKAGE     = "1"

    // ENVIRONMENT
    NODE_ENV = "production"

    FETCH_KEEPALIVE_ENABLED = "true"
    // see https://github.com/MicrosoftDocs/azure-docs/issues/29600#issuecomment-607990556
    // and https://docs.microsoft.com/it-it/azure/app-service/app-service-web-nodejs-best-practices-and-troubleshoot-guide#scenarios-and-recommendationstroubleshooting
    // FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL should not exceed 120000 (app service socket timeout)
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL = "110000"
    // (FETCH_KEEPALIVE_MAX_SOCKETS * number_of_node_processes) should not exceed 160 (max sockets per VM)
    FETCH_KEEPALIVE_MAX_SOCKETS         = "128"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"


    # REDIS
    REDIS_URL      = module.redis_cache.hostname
    REDIS_PORT     = module.redis_cache.ssl_port
    REDIS_PASSWORD = module.redis_cache.primary_access_key

    # SPID
    ORG_ISSUER       = "https://spid.agid.gov.it/cd"
    ORG_URL          = format("https://%s/spid/v1", trim(azurerm_dns_a_record.api[0].fqdn, "."))
    ORG_DISPLAY_NAME = "Organization display name"
    ORG_NAME         = "Organization name"

    AUTH_N_CONTEXT = "https://www.spid.gov.it/SpidL2"

    ENDPOINT_ACS      = "/acs"
    ENDPOINT_ERROR    = "/error"
    ENDPOINT_SUCCESS  = format("https://%s/", module.cdn_portal_frontend.hostname)
    ENDPOINT_LOGIN    = "/login"
    ENDPOINT_METADATA = "/metadata"
    ENDPOINT_LOGOUT   = "/logout"

    SPID_ATTRIBUTES    = "address,email,name,familyName,fiscalNumber,mobilePhone"
    SPID_TESTENV_URL   = format("https://%s", azurerm_container_group.spid_testenv[0].fqdn)
    SPID_VALIDATOR_URL = "https://validator.spid.gov.it"

    METADATA_PUBLIC_CERT  = tls_self_signed_cert.spid_self.cert_pem
    METADATA_PRIVATE_CERT = tls_private_key.spid.private_key_pem

    ENABLE_JWT                         = "true"
    INCLUDE_SPID_USER_ON_INTROSPECTION = "true"

    JWT_TOKEN_EXPIRATION  = "3600"
    JWT_TOKEN_ISSUER      = "SPID"
    JWT_TOKEN_PRIVATE_KEY = tls_private_key.jwt.private_key_pem

    # application insights key
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key

  }

  linux_fx_version = "NODE|12-lts"

  always_on = "true"

  allowed_subnets = [azurerm_subnet.subnet_apim.id]
  allowed_ips     = []

  subnet_name = module.subnet_spid_login.name
  subnet_id   = module.subnet_spid_login.id

  tags = var.tags

}


############
### APIM ###
############
locals {
  apim_name                     = format("%s-apim", local.project)
  apim_cert_name_proxy_endpoint = format("%s-proxy-endpoint-cert", local.project)
}

module "apim" {
  source                    = "./modules/apim"
  subnet_id                 = azurerm_subnet.subnet_apim.id
  location                  = var.location
  resource_name             = local.apim_name
  resource_group_name       = azurerm_resource_group.rg_api.name
  publisher_name            = var.apim_publisher_name
  publisher_email           = var.apim_publisher_email
  notification_sender_email = var.apim_notification_sender_email
  sku_name                  = var.apim_sku
  xml_content = templatefile("./apim_global/policy.xml.tpl", {
    origins = var.apim_allowed_origins
  })
  tags = var.tags
}

resource "azurerm_key_vault_certificate" "apim_proxy_endpoint_cert" {
  name         = local.apim_cert_name_proxy_endpoint
  key_vault_id = azurerm_key_vault.key_vault.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = format("CN=%s", trim(azurerm_private_dns_a_record.private_dns_a_record_api.fqdn, "."))
      validity_in_months = 12

      subject_alternative_names {
        dns_names = [
          trim(azurerm_private_dns_a_record.private_dns_a_record_api.fqdn, "."),
        ]
      }
    }
  }
}

resource "azurerm_api_management_custom_domain" "api_custom_domain" {
  api_management_id = module.apim.id

  proxy {
    host_name    = trim(azurerm_private_dns_a_record.private_dns_a_record_api.fqdn, ".")
    key_vault_id = azurerm_key_vault_certificate.apim_proxy_endpoint_cert.secret_id
  }

  # developer_portal {
  #   host_name    = "portal.example.com"
  #   key_vault_id = azurerm_key_vault_certificate.test.secret_id
  # }
}

resource "azurerm_api_management_certificate" "jwt_certificate" {
  name                = "jwt-spid-crt"
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  data                = pkcs12_from_pem.jwt_pkcs12.result
}

# APIs

module "apim_backend_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=main"

  name                = format("%s-backend-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Backend"
  display_name = "BACKEND"
  path         = "api/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", module.portal_backend_1.default_site_hostname)

  content_value = file("./backend_api/swagger.json")

  xml_content = file("./backend_api/policy.xml")
}


module "apim_backoffice_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=main"

  name                = format("%s-backoffice-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Backoffice"
  display_name = "BACKOFFICE"
  path         = "backoffice/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", module.portal_backend_1.default_site_hostname)

  content_value = file("./backoffice_api/swagger.json")

  xml_content = file("./backoffice_api/policy.xml")
}

module "apim_spid_login_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=main"

  name                = format("%s-spid-login-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "Login SPID Service Provider"
  display_name = "SPID"
  path         = "spid/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", module.spid_login.default_site_hostname)

  content_value = file("./spidlogin_api/swagger.json")

  xml_content = file("./spidlogin_api/policy.xml")
}
