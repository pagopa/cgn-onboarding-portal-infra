# General

data "azurerm_client_config" "current" {}

# Resource Groups

data "azurerm_resource_group" "rg_api" {
  name = format("%s-api-rg", local.project)
}

data "azurerm_resource_group" "rg_vnet" {
  name = format("%s-vnet-rg", local.project)
}

data "azurerm_resource_group" "rg_spid_testenv" {
  count = var.enable_spid_test ? 1 : 0
  name  = format("%s-spid-testenv-rg", local.project)
}

data "azurerm_resource_group" "rg_sec" {
  name = format("%s-sec-rg", local.project)
}

data "azurerm_resource_group" "rg_public" {
  name = format("%s-public-rg", local.project)
}

# Networking

# data "azurerm_subnet" "subnet_apim" {
#   name                 = format("%s-apim-subnet", local.project)
#   resource_group_name  = data.azurerm_resource_group.rg_vnet.name
#   virtual_network_name = data.azurerm_virtual_network.vnet.name
# }

data "azurerm_virtual_network" "vnet" {
  name                = format("%s-vnet", local.project)
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

# DNS
data "azurerm_dns_cname_record" "frontend" {
  count               = var.enable_custom_dns ? 1 : 0
  name                = "portal"
  resource_group_name = data.azurerm_resource_group.rg_public.name
  zone_name           = var.dns_zone_prefix != null ? data.azurerm_dns_zone.public[0].name : data.azurerm_dns_zone.public_uat[0].name
}

# data "azurerm_private_dns_a_record" "private_dns_a_record_api" {
#   name                = local.apim_name
#   zone_name           = data.azurerm_private_dns_zone.api_private_dns_zone.name
#   resource_group_name = data.azurerm_resource_group.rg_vnet.name
# }

# data "azurerm_private_dns_zone" "api_private_dns_zone" {
#   name                = "api.cgnonboardingportal.pagopa.it"
#   resource_group_name = data.azurerm_resource_group.rg_vnet.name
# }

data "azurerm_dns_zone" "public" {
  count               = (var.dns_zone_prefix == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_prefix, var.external_domain])
  resource_group_name = data.azurerm_resource_group.rg_public.name
}

data "azurerm_dns_zone" "public_uat" {
  count               = (var.dns_zone_prefix_uat == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_prefix_uat, var.external_domain])
  resource_group_name = data.azurerm_resource_group.rg_public.name
}

# SPID
data "azurerm_container_group" "spid_testenv" {
  count               = var.enable_spid_test ? 1 : 0
  name                = format("%s-spid-testenv", local.project)
  resource_group_name = data.azurerm_resource_group.rg_spid_testenv[0].name
}

# App services

data "azurerm_linux_web_app" "spid_login" {
  name                = format("%s-spid-login", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_linux_web_app" "ade_aa_mock" {
  count               = var.enable_ade_aa_mock ? 1 : 0
  name                = format("%s-ade-aa-mock", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_linux_web_app" "portal_backend_1" {
  name                = format("%s-portal-backend1", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

# Security
data "azurerm_key_vault" "key_vault" {
  name                = format("%s-kv", local.project)
  resource_group_name = data.azurerm_resource_group.rg_sec.name
}

data "azurerm_key_vault_secret" "jwt_pkcs12_pem" {
  name         = "jwt-pkcs12-pem"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

# data "azurerm_key_vault_certificate" "apim_proxy_endpoint_cert" {
#   name         = local.apim_cert_name_proxy_endpoint
#   key_vault_id = data.azurerm_key_vault.key_vault.id
# }