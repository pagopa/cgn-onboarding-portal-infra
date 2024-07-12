locals {
  project = format("%s-%s", var.prefix, var.env_short)
  
  apim_name                     = format("%s-apim", local.project)
  apim_cert_name_proxy_endpoint = format("%s-proxy-endpoint-cert", local.project)
  apim_origins = flatten([
    [var.enable_custom_dns ? [format("https://%s", trim(data.azurerm_dns_cname_record.frontend[0].fqdn, "."))] : []],
    [format("https://%s/", "${format("%s-cdnendpoint-frontend", local.project)}.azureedge.net")],
    [var.enable_spid_test ? ["http://localhost:3000"] : []]
  ])

  spid_acs_origins = flatten([
    [var.enable_spid_test ? [format("https://%s", trim(data.azurerm_container_group.spid_testenv[0].fqdn, "."))] : []],
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

  cdn_frontend_url        = format("https://%s/", "${format("%s-cdnendpoint-frontend", local.project)}.azureedge.net")
  custom_dns_frontend_url = format("https://%s/", trim(data.azurerm_dns_cname_record.frontend[0].fqdn, "."))

  # portal_backend_1_app_settings = {
  #   WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
  #   WEBSITES_PORT                       = 8080
  #   WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
  #   WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"

  #   DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.container_registry.login_server}"
  #   DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.container_registry.admin_username
  #   DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.container_registry.admin_password

  #   # DNS configuration to use private endpoint
  #   WEBSITE_DNS_SERVER                  = "168.63.129.16"
  #   WEBSITE_VNET_ROUTE_ALL              = 1
  #   WEBSITES_CONTAINER_START_TIME_LIMIT = 600

  #   # These are app specific environment variables
  #   SPRING_PROFILES_ACTIVE = "prod"
  #   SERVER_PORT            = 8080
  #   SPRING_DATASOURCE_URL  = format("jdbc:postgresql://%s:5432/%s?%s", trimsuffix(azurerm_private_dns_a_record.private_dns_a_record_postgresql.fqdn, "."), var.database_name, "sslmode=require")
  #   SPRING_DATASOURCE_USERNAME = format("%s@%s",
  #     data.azurerm_key_vault_secret.db_administrator_login.value,
  #     azurerm_postgresql_server.postgresql_server.name
  #   )
  #   SPRING_DATASOURCE_PASSWORD = data.azurerm_key_vault_secret.db_administrator_login_password.value
  #   JAVA_OPTS                  = "-XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:+UseStringDeduplication"

  #   # Blob Storage Account
  #   CGN_PE_STORAGE_AZURE_DEFAULT_ENDPOINTS_PROTOCOL = "https"
  #   CGN_PE_STORAGE_AZURE_ACCOUNT_NAME               = module.storage_account.name
  #   CGN_PE_STORAGE_AZURE_ACCOUNT_KEY                = module.storage_account.primary_access_key
  #   CGN_PE_STORAGE_AZURE_BLOB_ENDPOINT              = module.storage_account.primary_blob_endpoint
  #   CGN_PE_STORAGE_AZURE_DOCUMENTS_CONTAINER_NAME   = azurerm_storage_container.user_documents.name
  #   CGN_PE_STORAGE_AZURE_IMAGED_CONTAINER_NAME      = azurerm_storage_container.profile_images.name

  #   # File Upload
  #   SPRING_SERVLET_MULTIPART_MAX_FILE_SIZE    = "200MB"
  #   SPRING_SERVLET_MULTIPART_MAX_REQUEST_SIZE = "200MB"

  #   # Bucket
  #   CGN_PE_DISCOUNT_BUCKET_MINCSVROWS = var.pe_min_csv_rows

  #   # EMAIL
  #   MANAGEMENT_HEALTH_MAIL_ENABLED                     = "false"
  #   SPRING_MAIL_HOST                                   = var.email_host
  #   SPRING_MAIL_PORT                                   = var.email_port
  #   SPRING_MAIL_USERNAME                               = data.azurerm_key_vault_secret.email_username.value
  #   SPRING_MAIL_PASSWORD                               = data.azurerm_key_vault_secret.email_password.value
  #   SPRING_MAIL_PROPERTIES_MAIL_SMTP_CONNECTIONTIMEOUT = 10000
  #   SPRING_MAIL_PROPERTIES_MAIL_SMTP_TIMEOUT           = 10000
  #   SPRING_MAIL_PROPERTIES_MAIL_SMTP_WRITETIMEOUT      = 10000

  #   # QUARTZ SCHEDULER
  #   SPRING_QUARTZ_AUTOSTARTUP = "true"

  #   CGN_EMAIL_NOTIFICATION_SENDER = "CGN Portal<no-reply@cgn.pagopa.it>"
  #   CGN_EMAIL_DEPARTMENT_EMAIL    = var.email_department_email
  #   CGN_EMAIL_PORTAL_BASE_URL     = var.enable_custom_dns ? local.custom_dns_frontend_url : local.cdn_frontend_url

  #   # EYCA EXPORT
  #   EYCA_EXPORT_ENABLED  = var.eyca_export_enabled
  #   EYCA_EXPORT_USERNAME = data.azurerm_key_vault_secret.eyca_export_username.value
  #   EYCA_EXPORT_PASSWORD = data.azurerm_key_vault_secret.eyca_export_password.value

  #   # APIM API TOKEN
  #   CGN_APIM_RESOURCEGROUP = var.io_apim_resourcegroup != null ? var.io_apim_resourcegroup : azurerm_resource_group.rg_api.name
  #   CGN_APIM_RESOURCE      = var.io_apim_v2_name != null ? var.io_apim_v2_name : module.apim.name
  #   CGN_APIM_PRODUCTID     = var.io_apim_v2_productid != null ? var.io_apim_v2_productid : azurerm_api_management_product.cgn_onbording_portal.id
  #   AZURE_SUBSCRIPTION_ID  = var.io_apim_subscription_id != null ? var.io_apim_subscription_id : data.azurerm_subscription.current.subscription_id

  #   # RECAPTCHA
  #   CGN_RECAPTCHA_SECRET_KEY = data.azurerm_key_vault_secret.recaptcha_secret_key.value

  #   # GEOLOCATION
  #   CGN_GEOLOCATION_SECRET_TOKEN = data.azurerm_key_vault_secret.backend_geolocation_token.value

  #   # ATTRIBUTE AUTHORITY
  #   CGN_ATTRIBUTE_AUTHORITY_BASE_URL = format("https://%s/", module.ade_aa_mock[0].default_site_hostname)

  #   # application insights
  #   APPLICATIONINSIGHTS_CONNECTION_STRING = format("InstrumentationKey=%s",
  #   azurerm_application_insights.application_insights.instrumentation_key)
  # }
  # portal_backend_1_app_settings_prod = {
  #   WEBSITE_ENABLE_SYNC_UPDATE_SITE = true
  # }

  # portal_backend_1_app_settings_staging = {
  #   # QUARTZ SCHEDULER
  #   SPRING_QUARTZ_AUTOSTARTUP = "false"
  # }

  # # APIM v2 app settings (NEW)
  # portal_backend_1_app_settings_v2 = merge(local.portal_backend_1_app_settings, local.portal_backend_1_app_settings_updated)

  # portal_backend_1_app_settings_updated = {
  #   CGN_APIM_RESOURCE      = var.io_apim_v2_name != null ? var.io_apim_v2_name : module.apim_v2.name
  #   CGN_APIM_PRODUCTID     = var.io_apim_v2_productid != null ? var.io_apim_v2_productid : azurerm_api_management_product.cgn_onbording_portal_v2.id
  # }
}