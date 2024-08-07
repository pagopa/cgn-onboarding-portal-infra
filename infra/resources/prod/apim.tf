#-------------------- J W T C E R T -------------------------

resource "azurerm_api_management_certificate" "jwt_certificate_v2" {
  name                = "jwt-spid-crt"
  api_management_name = module.apim_v2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  data                = data.azurerm_key_vault_secret.jwt_pkcs12_pem.value
}

#-------------------- A P I -------------------------

resource "azurerm_api_management_product" "cgn_onbording_portal_v2" {
  product_id            = "cgn-onboarding-portal-api"
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  api_management_name   = module.apim_v2.name
  display_name          = "CGN ONBOARDING PORTAL API"
  description           = "CGN Onboarding Portal API"
  subscription_required = true
  approval_required     = false
  published             = true
}

module "apim_backend_api_v2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v8.26.5"

  name                = format("%s-backend-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Backend"
  display_name = "BACKEND"
  path         = "api/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", data.azurerm_linux_web_app.portal_backend_1.default_hostname)

  content_value = file("../../../code/backend_api/swagger.json")

  xml_content = templatefile("../../../code/backend_api/policy.xml.tpl", {
    hub_spid_login_url = format("https://%s", data.azurerm_linux_web_app.spid_login.default_hostname)
  })
}


module "apim_backoffice_api_v2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v8.26.5"

  name                = format("%s-backoffice-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Backoffice"
  display_name = "BACKOFFICE"
  path         = "backoffice/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", data.azurerm_linux_web_app.portal_backend_1.default_hostname)

  content_value = file("../../../code/backoffice_api/swagger.json")

  xml_content = templatefile("../../../code/backoffice_api/policy.xml.tpl", {
    openid_config_url = var.adb2c_openid_config_url
    audience          = var.adb2c_audience
  })
}

module "apim_public_api_v2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v8.26.5"

  name                = format("%s-public-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  description  = "CGN Onboarding Portal Public"
  display_name = "PUBLIC"
  path         = "public/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", data.azurerm_linux_web_app.portal_backend_1.default_hostname)

  content_value = file("../../../code/public_api/swagger.json")

  xml_content = file("../../../code/public_api/policy.xml")
}

module "apim_spid_login_api_v2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v8.26.5"

  name                = format("%s-spid-login-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  description  = "Login SPID Service Provider"
  display_name = "SPID"
  path         = "spid/v1"
  protocols    = ["http", "https"]
  service_url  = format("https://%s", data.azurerm_linux_web_app.spid_login.default_hostname)

  content_value = file("../../../code/spidlogin_api/swagger.json")

  xml_content = file("../../../code/spidlogin_api/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "spid_acs_v2" {
  api_name            = format("%s-spid-login-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "postACS"

  xml_content = templatefile("../../../code/spidlogin_api/postacs_policy.xml.tpl", {
    origins = local.spid_acs_origins
  })
}

module "apim_ade_aa_mock_api_v2" {
  count  = var.enable_ade_aa_mock ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v8.26.5"

  name                = format("%s-ade-aa-mock-api", local.project)
  api_management_name = module.apim_v2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  description           = "ADE Attribute Authority Microservice Mock"
  display_name          = "ADEAA"
  path                  = "adeaa/v1"
  protocols             = ["http", "https"]
  service_url           = format("https://%s", data.azurerm_linux_web_app.ade_aa_mock[0].default_hostname)
  subscription_required = true

  product_ids = ["cgn-onboarding-portal-api"]

  content_value = file("../../../code/adeaa_api/swagger.json")

  xml_content = file("../../../code/adeaa_api/policy.xml")
}

#-------------------- S E C U R I T Y -------------------------

resource "azurerm_key_vault_access_policy" "api_management_policy_v2" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim_v2.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}


#-------------------- A P I M -------------------------

module "apim_v2" {
  source                    = "../../modules/apim"
  subnet_id                 = azurerm_subnet.subnet_apim_v2.id
  location                  = var.location
  resource_name             = "${local.apim_name}-v2"
  resource_group_name       = data.azurerm_resource_group.rg_api.name
  publisher_name            = var.apim_publisher_name
  publisher_email           = var.apim_publisher_email
  notification_sender_email = var.apim_notification_sender_email
  sku_name                  = var.apim_sku
  xml_content = templatefile("../../../code/apim_global/policy.xml.tpl", {
    origins = local.apim_origins
  })
  tags = var.tags
}

resource "azurerm_subnet" "subnet_apim_v2" {
  name                 = format("%s-api-subnet-v2", local.project)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_cidr

  service_endpoints = ["Microsoft.Web"]

  private_endpoint_network_policies = "Disabled"
}

resource "azurerm_network_security_group" "nsg_apim_v2" {
  name                = format("%s-apim-nsg-v2", local.project)
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

resource "azurerm_subnet_network_security_group_association" "snet_nsg_v2" {
  subnet_id                 = azurerm_subnet.subnet_apim_v2.id
  network_security_group_id = azurerm_network_security_group.nsg_apim_v2.id
}