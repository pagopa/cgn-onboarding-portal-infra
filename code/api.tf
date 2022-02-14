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

locals {
  portal_backend_1_app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"

    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.container_registry.admin_password

    # DNS configuration to use private endpoint
    WEBSITE_DNS_SERVER     = "168.63.129.16"
    WEBSITE_VNET_ROUTE_ALL = 1

    # These are app specific environment variables
    SPRING_PROFILES_ACTIVE = "prod"
    SERVER_PORT            = 8080
    SPRING_DATASOURCE_URL  = format("jdbc:postgresql://%s:5432/%s?%s", trimsuffix(azurerm_private_dns_a_record.private_dns_a_record_postgresql.fqdn, "."), var.database_name, "sslmode=require")
    SPRING_DATASOURCE_USERNAME = format("%s@%s",
      data.azurerm_key_vault_secret.db_administrator_login.value,
      azurerm_postgresql_server.postgresql_server.name
    )
    SPRING_DATASOURCE_PASSWORD = data.azurerm_key_vault_secret.db_administrator_login_password.value
    JAVA_OPTS                  = "-XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication"

    # Blob Storage Account
    CGN_PE_STORAGE_AZURE_DEFAULT_ENDPOINTS_PROTOCOL = "https"
    CGN_PE_STORAGE_AZURE_ACCOUNT_NAME               = module.storage_account.name
    CGN_PE_STORAGE_AZURE_ACCOUNT_KEY                = module.storage_account.primary_access_key
    CGN_PE_STORAGE_AZURE_BLOB_ENDPOINT              = module.storage_account.primary_blob_endpoint
    CGN_PE_STORAGE_AZURE_DOCUMENTS_CONTAINER_NAME   = azurerm_storage_container.user_documents.name
    CGN_PE_STORAGE_AZURE_IMAGED_CONTAINER_NAME      = azurerm_storage_container.profile_images.name

    # File Upload
    SPRING_SERVLET_MULTIPART_MAX_FILE_SIZE    = "200MB"
    SPRING_SERVLET_MULTIPART_MAX_REQUEST_SIZE = "200MB"

    # Bucket
    CGN_PE_DISCOUNT_BUCKET_MINCSVROWS = var.pe_min_csv_rows

    # EMAIL
    MANAGEMENT_HEALTH_MAIL_ENABLED                     = "false"
    SPRING_MAIL_HOST                                   = var.email_host
    SPRING_MAIL_PORT                                   = var.email_port
    SPRING_MAIL_USERNAME                               = data.azurerm_key_vault_secret.email_username.value
    SPRING_MAIL_PASSWORD                               = data.azurerm_key_vault_secret.email_password.value
    SPRING_MAIL_PROPERTIES_MAIL_SMTP_CONNECTIONTIMEOUT = 10000
    SPRING_MAIL_PROPERTIES_MAIL_SMTP_TIMEOUT           = 10000
    SPRING_MAIL_PROPERTIES_MAIL_SMTP_WRITETIMEOUT      = 10000

    CGN_EMAIL_NOTIFICATION_SENDER = "CGN Portal<no-reply@cgn.pagopa.it>"
    CGN_EMAIL_DEPARTMENT_EMAIL    = var.email_department_email
    CGN_EMAIL_PORTAL_BASE_URL     = var.enable_custom_dns ? local.custom_dns_frontend_url : local.cdn_frontend_url

    # APIM API TOKEN
    CGN_APIM_RESOURCEGROUP = var.io_apim_resourcegroup != null ? var.io_apim_resourcegroup : azurerm_resource_group.rg_api.name
    CGN_APIM_RESOURCE      = var.io_apim_name != null ? var.io_apim_name : module.apim.name
    CGN_APIM_PRODUCTID     = var.io_apim_productid != null ? var.io_apim_productid : azurerm_api_management_product.cgn_onbording_portal.id
    AZURE_SUBSCRIPTION_ID  = var.io_apim_subscription_id != null ? var.io_apim_subscription_id : data.azurerm_subscription.current.subscription_id
    # RECAPTCHA
    CGN_RECAPTCHA_SECRET_KEY = data.azurerm_key_vault_secret.recaptcha_secret_key.value

    # GEOLOCATION
    CGN_GEOLOCATION_SECRET_TOKEN = data.azurerm_key_vault_secret.backend_geolocation_token.value

    # application insights
    APPLICATIONINSIGHTS_CONNECTION_STRING = format("InstrumentationKey=%s",
    azurerm_application_insights.application_insights.instrumentation_key)
  }
}

module "portal_backend_1" {
  source = "./modules/app_service"

  name                = format("%s-portal-backend1", local.project)
  plan_name           = format("%s-plan-portal-backend1", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name

  sku = var.backend_sku

  health_check_path = "/actuator/health"

  app_settings = local.portal_backend_1_app_settings

  slot_name         = "staging"
  app_settings_slot = local.portal_backend_1_app_settings

  linux_fx_version = format("DOCKER|%s/cgn-onboarding-portal-backend:%s",
  azurerm_container_registry.container_registry.login_server, "latest")
  always_on = "true"

  allowed_subnets = [azurerm_subnet.subnet_apim.id]
  allowed_ips     = []

  subnet_name = module.subnet_api.name
  subnet_id   = module.subnet_api.id

  tags = var.tags
}

data "azurerm_key_vault_secret" "backend_client_id" {
  name         = "backend-CLIENT-ID"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "backend_client_secret" {
  name         = "backend-CLIENT-SECRET"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "backend_geolocation_token" {
  name         = "backend-GEOLOCATION-TOKEN"
  key_vault_id = module.key_vault.id
}

############################
## App service spid login ##
############################
module "spid_login" {
  source = "./modules/app_service"

  name                = format("%s-spid-login", local.project)
  plan_name           = format("%s-plan-spid-login", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name

  sku = var.hub_spid_login_sku

  health_check_path = "/healthcheck"

  app_settings = merge({
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
    ORG_ISSUER       = "https://cgnonboardingportal.pagopa.it/pub-op-full"
    ORG_URL          = "https://pagopa.gov.it"
    ACS_BASE_URL     = format("https://%s/spid/v1", var.app_gateway_host_name)
    ORG_DISPLAY_NAME = "PagoPA S.p.A"
    ORG_NAME         = "PagoPA"

    AUTH_N_CONTEXT = "https://www.spid.gov.it/SpidL2"

    ENDPOINT_ACS      = "/acs"
    ENDPOINT_ERROR    = "/error"
    ENDPOINT_SUCCESS  = var.enable_custom_dns ? local.custom_dns_frontend_url : local.cdn_frontend_url
    ENDPOINT_LOGIN    = "/login"
    ENDPOINT_METADATA = "/metadata"
    ENDPOINT_LOGOUT   = "/logout"

    SPID_ATTRIBUTES    = "address,email,name,familyName,fiscalNumber,mobilePhone"
    SPID_VALIDATOR_URL = "https://validator.spid.gov.it"

    REQUIRED_ATTRIBUTES_SERVICE_NAME = "Carta Giovani Nazionale Onboarding Portal"
    ENABLE_FULL_OPERATOR_METADATA    = true
    COMPANY_EMAIL                    = "pagopa@pec.governo.it"
    COMPANY_FISCAL_CODE              = 15376371009
    COMPANY_IPA_CODE                 = "PagoPA"
    COMPANY_NAME                     = "PagoPA S.p.A"
    COMPANY_VAT_NUMBER               = 15376371009

    METADATA_PUBLIC_CERT  = var.agid_spid_public_cert != null ? trimspace(data.azurerm_key_vault_secret.agid_spid_cert[0].value) : trimspace(tls_self_signed_cert.spid_self.cert_pem)
    METADATA_PRIVATE_CERT = var.agid_spid_private_key != null ? trimspace(data.azurerm_key_vault_secret.agid_spid_private_key[0].value) : trimspace(tls_private_key.spid.private_key_pem)

    ENABLE_JWT                         = "true"
    INCLUDE_SPID_USER_ON_INTROSPECTION = "true"

    TOKEN_EXPIRATION      = "3600"
    JWT_TOKEN_ISSUER      = "SPID"
    JWT_TOKEN_PRIVATE_KEY = trimspace(tls_private_key.jwt.private_key_pem)

    # ADE
    ENABLE_ADE_AA        = "true"
    ADE_AA_API_ENDPOINT  = format("https://%s/", module.ade_aa_mock[0].default_site_hostname)
    ENDPOINT_L1_SUCCESS  = var.enable_custom_dns ? local.custom_dns_frontend_url : local.cdn_frontend_url
    L1_TOKEN_EXPIRATION  = 120
    L1_TOKEN_HEADER_NAME = "x-cgn-token"
    L2_TOKEN_EXPIRATION  = 3600

    # application insights key
    APPINSIGHTS_DISABLED           = false
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key

    # Spid logs
    ENABLE_SPID_ACCESS_LOGS             = var.enable_spid_access_logs
    SPID_LOGS_STORAGE_CONNECTION_STRING = "DefaultEndpointsProtocol=https;AccountName=${module.storage_account.name};AccountKey=${module.storage_account.primary_access_key};BlobEndpoint=${module.storage_account.primary_blob_endpoint};"
    SPID_LOGS_STORAGE_CONTAINER_NAME    = azurerm_storage_container.spid_logs.name
    SPID_LOGS_PUBLIC_KEY                = trimspace(data.azurerm_key_vault_secret.spid_logs_public_key.value)
    },
    var.enable_spid_test ? {
      SPID_TESTENV_URL = format("https://%s", azurerm_container_group.spid_testenv[0].fqdn)
    } : {}
  )

  linux_fx_version = "NODE|12-lts"

  always_on = "true"

  allowed_subnets = [azurerm_subnet.subnet_apim.id]
  allowed_ips     = []

  subnet_name = module.subnet_spid_login.name
  subnet_id   = module.subnet_spid_login.id

  tags = var.tags

}

#############################
## App service ADE AA MOCK ##
#############################
module "ade_aa_mock" {
  source = "./modules/app_service"
  count  = var.enable_ade_aa_mock ? 1 : 0

  name                = format("%s-ade-aa-mock", local.project)
  plan_name           = format("%s-ade-aa-mock-plan", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name

  sku = var.ade_aa_mock_sku

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    SERVER_PORT                         = 8080

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

    # Blob storage
    CONTAINER_NAME            = azurerm_storage_container.ade_aa_config[0].name
    BLOB_NAME                 = "userCompanies.json"
    STORAGE_CONNECTION_STRING = azurerm_storage_account.ade_aa_mock[0].primary_blob_connection_string

    # application insights key
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key

  }

  linux_fx_version = "NODE|12-lts"

  always_on = "true"

  allowed_subnets = [azurerm_subnet.subnet_apim.id, module.subnet_spid_login.id]
  allowed_ips     = []

  subnet_name = module.subnet_ade_aa_mock[0].name
  subnet_id   = module.subnet_ade_aa_mock[0].id

  tags = var.tags

}

## APP FUNCTION CGN SEARCH ##
#############################

resource "azurerm_resource_group" "os_rg" {
  name     = format("%s-search-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  operator_search_app_settings = {
    FUNCTIONS_WORKER_RUNTIME     = "node"
    WEBSITE_NODE_DEFAULT_VERSION = "12.18.0"
    WEBSITE_RUN_FROM_PACKAGE     = "1"
    NODE_ENV                     = "production"

    # DNS configuration to use private endpoint
    WEBSITE_DNS_SERVER     = "168.63.129.16"
    WEBSITE_VNET_ROUTE_ALL = 1

    CGN_POSTGRES_DB_ADMIN_URI = format("postgresql://%s:%s@%s:5432/%s",
      urlencode(format("%s@%s",
        data.azurerm_key_vault_secret.db_administrator_login.value,
      azurerm_postgresql_server.postgresql_server.name)),
      urlencode(
      data.azurerm_key_vault_secret.db_administrator_login_password.value),
      trimsuffix(azurerm_postgresql_server.postgresql_server.fqdn, "."),
      var.database_name
    )
    CGN_POSTGRES_DB_RO_URI = format("postgresql://%s:%s@%s:5432/%s",
      urlencode(format("%s@%s",
        data.azurerm_key_vault_secret.db_administrator_login.value,
      azurerm_postgresql_server.postgresql_server.name)),
      urlencode(
        data.azurerm_key_vault_secret.db_administrator_login_password.value
      ),
    trimsuffix(azurerm_postgresql_server.postgresql_server.fqdn, "."), var.database_name)
    CGN_POSTGRES_DB_SSL_ENABLED = "true"

    CDN_MERCHANT_IMAGES_BASE_URL = format("https://%s", module.cdn_portal_storage.hostname)

  }
}


module "operator_search" {
  source = "./modules/app_function"

  name                = format("%s-os", local.project)
  resource_group_name = azurerm_resource_group.os_rg.name

  slot_name = "staging"

  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(local.operator_search_app_settings, {
    SLOT_TASK_HUBNAME = "ProductionTaskHub"
  })

  app_settings_slot = merge(local.operator_search_app_settings, {
    SLOT_TASK_HUBNAME = "SlotTaskHub"
  })



  allowed_subnets = concat(
    [azurerm_subnet.subnet_apim.id, ],
    var.operator_search_external_allowed_subnets,
  )

  subnet_name = module.subnet_function.name
  subnet_id   = module.subnet_function.id

  tags = var.tags
}

############
### APIM ###
############
locals {
  apim_name                     = format("%s-apim", local.project)
  apim_cert_name_proxy_endpoint = format("%s-proxy-endpoint-cert", local.project)
  apim_origins = flatten([
    [var.enable_custom_dns ? [format("https://%s", trim(azurerm_dns_cname_record.frontend[0].fqdn, "."))] : []],
    [format("https://%s/", module.cdn_portal_frontend.hostname)],
    [var.enable_spid_test ? ["http://localhost:3000"] : []]
  ])

  spid_acs_origins = flatten([
    [var.enable_spid_test ? [format("https://%s", trim(azurerm_container_group.spid_testenv[0].fqdn, "."))] : []],
    [
      "https://id.lepida.it",
      "https://identity.infocert.it",
      "https://identity.sieltecloud.it",
      "https://idp.namirialtsp.com",
      "https://login.id.tim.it",
      "https://loginspid.aruba.it",
      "https://posteid.poste.it",
      "https://spid.intesa.it",
    "https://spid.register.it"]
  ])

  cdn_frontend_url        = format("https://%s/", module.cdn_portal_frontend.hostname)
  custom_dns_frontend_url = format("https://%s/", trim(azurerm_dns_cname_record.frontend[0].fqdn, "."))
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
    origins = local.apim_origins
  })
  tags = var.tags
}

resource "azurerm_key_vault_certificate" "apim_proxy_endpoint_cert" {
  name         = local.apim_cert_name_proxy_endpoint
  key_vault_id = module.key_vault.id

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

# API Product

resource "azurerm_api_management_product" "cgn_onbording_portal" {
  product_id            = "cgn-onboarding-portal-api"
  resource_group_name   = azurerm_resource_group.rg_api.name
  api_management_name   = module.apim.name
  display_name          = "CGN ONBOARDING PORTAL API"
  description           = "CGN Onboarding Portal API"
  subscription_required = true
  approval_required     = false
  published             = true
}


# APIs

module "apim_backend_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2"

  name                = format("%s-backend-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Backend"
  display_name = "BACKEND"
  path         = "api/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", module.portal_backend_1.default_site_hostname)

  content_value = file("./backend_api/swagger.json")

  xml_content = templatefile("./backend_api/policy.xml.tpl", {
    hub_spid_login_url = format("https://%s", module.spid_login.default_site_hostname)
  })
}


module "apim_backoffice_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2"

  name                = format("%s-backoffice-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Backoffice"
  display_name = "BACKOFFICE"
  path         = "backoffice/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", module.portal_backend_1.default_site_hostname)

  content_value = file("./backoffice_api/swagger.json")

  xml_content = templatefile("./backoffice_api/policy.xml.tpl", {
    openid_config_url = var.adb2c_openid_config_url
    audience          = var.adb2c_audience
  })
}

module "apim_public_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2"

  name                = format("%s-public-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Public"
  display_name = "PUBLIC"
  path         = "public/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", module.portal_backend_1.default_site_hostname)

  content_value = file("./public_api/swagger.json")

  xml_content = file("./public_api/policy.xml")
}

module "apim_spid_login_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2"

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

resource "azurerm_api_management_api_operation_policy" "spid_acs" {
  api_name            = format("%s-spid-login-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = "postACS"

  xml_content = templatefile("./spidlogin_api/postacs_policy.xml.tpl", {
    origins = local.spid_acs_origins
  })
}

module "apim_ade_aa_mock_api" {
  count  = var.enable_ade_aa_mock ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2"

  name                = format("%s-ade-aa-mock-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description           = "ADE Attribute Authority Microservice Mock"
  display_name          = "ADEAA"
  path                  = "adeaa/v1"
  protocols             = ["http", "https"]
  service_url           = format("https://%s", module.ade_aa_mock[0].default_site_hostname)
  subscription_required = true

  product_ids = ["cgn-onboarding-portal-api"]

  content_value = file("./adeaa_api/swagger.json")

  xml_content = file("./adeaa_api/policy.xml")
}
