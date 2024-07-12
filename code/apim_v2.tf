

resource "azurerm_api_management_custom_domain" "api_custom_domain_v2" {
  api_management_id = module.apim_v2.id

  proxy {
    host_name    = trim(azurerm_private_dns_a_record.private_dns_a_record_api_v2.fqdn, ".")
    key_vault_id = azurerm_key_vault_certificate.apim_proxy_endpoint_cert.secret_id
  }
}

resource "azurerm_api_management_certificate" "jwt_certificate_v2" {
  name                = "jwt-spid-crt"
  api_management_name = module.apim_v2.name
  resource_group_name = azurerm_resource_group.rg_api.name
  data                = pkcs12_from_pem.jwt_pkcs12.result
}

# API Product

resource "azurerm_api_management_product" "cgn_onbording_portal_v2" { # Nell'app service
  product_id            = "cgn-onboarding-portal-api"
  resource_group_name   = azurerm_resource_group.rg_api.name
  api_management_name   = module.apim_v2.name
  display_name          = "CGN ONBOARDING PORTAL API"
  description           = "CGN Onboarding Portal API"
  subscription_required = true
  approval_required     = false
  published             = true
}

# APIs

module "apim_backend_api_v2" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2"

  name                = format("%s-backend-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Backend"
  display_name = "BACKEND"
  path         = "api/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", module.portal_backend_1_v2.default_site_hostname)

  content_value = file("./backend_api/swagger.json")

  xml_content = templatefile("./backend_api/policy.xml.tpl", {
    hub_spid_login_url = format("https://%s", module.spid_login.default_site_hostname)
  })
}


module "apim_backoffice_api_v2" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2"

  name                = format("%s-backoffice-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Backoffice"
  display_name = "BACKOFFICE"
  path         = "backoffice/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", module.portal_backend_1_v2.default_site_hostname)

  content_value = file("./backoffice_api/swagger.json")

  xml_content = templatefile("./backoffice_api/policy.xml.tpl", {
    openid_config_url = var.adb2c_openid_config_url
    audience          = var.adb2c_audience
  })
}

module "apim_public_api_v2" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2"

  name                = format("%s-public-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Public"
  display_name = "PUBLIC"
  path         = "public/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", module.portal_backend_1_v2.default_site_hostname)

  content_value = file("./public_api/swagger.json")

  xml_content = file("./public_api/policy.xml")
}

module "apim_spid_login_api_v2" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2"

  name                = format("%s-spid-login-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "Login SPID Service Provider"
  display_name = "SPID"
  path         = "spid/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", module.spid_login.default_site_hostname)

  content_value = file("./spidlogin_api/swagger.json")

  xml_content = file("./spidlogin_api/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "spid_acs_v2" {
  api_name            = format("%s-spid-login-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = "postACS"

  xml_content = templatefile("./spidlogin_api/postacs_policy.xml.tpl", {
    origins = local.spid_acs_origins
  })
}

module "apim_ade_aa_mock_api_v2" {
  count  = var.enable_ade_aa_mock ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.2"

  name                = format("%s-ade-aa-mock-api", local.project)
  api_management_name = module.apim_v2.name
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

#---------------------------------------------
# NETWORK

resource "azurerm_private_dns_a_record" "private_dns_a_record_api_v2" {
  name                = "${local.apim_name}-v2"
  zone_name           = azurerm_private_dns_zone.api_private_dns_zone.name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = 300
  records             = module.apim_v2.*.private_ip_addresses[0]
}

# API file
resource "azurerm_key_vault_certificate" "apim_proxy_endpoint_cert_v2" {
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

      subject            = format("CN=%s", trim(azurerm_private_dns_a_record.private_dns_a_record_api_v2.fqdn, "."))
      validity_in_months = 12

      subject_alternative_names {
        dns_names = [
          trim(azurerm_private_dns_a_record.private_dns_a_record_api_v2.fqdn, "."),
        ]
      }
    }
  }
}

#---------------------------------------------
# Security

resource "azurerm_key_vault_access_policy" "api_management_policy_v2" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim_v2.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}


#---------------------------------------------

module "apim_v2" {
  source                    = "./modules/apim"
  subnet_id                 = azurerm_subnet.subnet_apim.id
  location                  = var.location
  resource_name             = "${local.apim_name}-v2"
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

resource "azurerm_network_security_group" "nsg_apim" {
  name                = format("%s-apim-v2-nsg", local.project)
  resource_group_name = format("%s-vnet-rg", local.project)
  location            = var.location

  security_rule {
    name                       = "managementapim"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "snet_nsg" {
  subnet_id                 = azurerm_subnet.subnet_apim.id
  network_security_group_id = azurerm_network_security_group.nsg_apim.id
}

#---------------------------------------------
# APP SERVICE

locals {
  portal_backend_1_app_settings_v2 = merge(local.portal_backend_1_app_settings, local.portal_backend_1_app_settings_updated)

  portal_backend_1_app_settings_updated = {
    CGN_APIM_RESOURCE      = var.io_apim_v2_name != null ? var.io_apim_v2_name : module.apim_v2.name
    CGN_APIM_PRODUCTID     = var.io_apim_v2_productid != null ? var.io_apim_v2_productid : azurerm_api_management_product.cgn_onbording_portal_v2.id
  }
}

module "portal_backend_1_v2" {
  source = "./modules/app_service"

  name                = format("%s-portal-backend1", local.project)
  plan_name           = format("%s-plan-portal-backend1", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name

  sku = var.backend_sku

  health_check_path = "/actuator/health"

  app_settings = merge(local.portal_backend_1_app_settings_v2, local.portal_backend_1_app_settings_prod)

  slot_name         = "staging"
  app_settings_slot = merge(local.portal_backend_1_app_settings_v2, local.portal_backend_1_app_settings_staging)

  linux_fx_version = format("DOCKER|%s/cgn-onboarding-portal-backend:%s",
  azurerm_container_registry.container_registry.login_server, "latest")
  always_on = "true"

  allowed_subnets = [azurerm_subnet.subnet_apim.id]
  allowed_ips     = []

  subnet_name = module.subnet_api.name
  subnet_id   = module.subnet_api.id

  tags = var.tags
}

# monitor file
resource "azurerm_monitor_metric_alert" "backend_5xx_v2" {
  name                = format("%s-%s", module.portal_backend_1_v2.name, "5xx")
  resource_group_name = azurerm_resource_group.monitor_rg.name
  scopes              = [module.portal_backend_1_v2.id]
  severity            = 1
  frequency           = "PT1M"
  window_size         = "PT5M"

  action {
    action_group_id = azurerm_monitor_action_group.p0action.id
  }

  criteria {
    aggregation      = "Count"
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    operator         = "GreaterThanOrEqual"
    threshold        = "10"
  }

  tags = var.tags
}