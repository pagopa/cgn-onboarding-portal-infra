# General

data "azurerm_client_config" "current" {}

# API

data "azurerm_key_vault_secret" "backend_geolocation_token" {
  name         = "backend-GEOLOCATION-TOKEN"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

# Resource Groups

data "azurerm_resource_group" "rg_api" {
  name = format("%s-api-rg", local.project)
}

data "azurerm_resource_group" "rg_vnet" {
  name = format("%s-search-rg", local.project)
}

data "azurerm_resource_group" "monitor_rg" {
  name     = format("%s-monitor-rg", local.project)
}

data "azurerm_resource_group" "rg_spid_testenv" {
  name     = format("%s-spid-testenv-rg", local.project)
}

data "azurerm_resource_group" "rg_sec" {
  name     = format("%s-sec-rg", local.project)
}

data "azurerm_resource_group" "rg_public" {
  name     = format("%s-public-rg", local.project)
}

# Subnet

data "azurerm_subnet" "subnet_apim" {
  name                 = format("%s-apim-subnet", local.project)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

data "azurerm_virtual_network" "vnet" {
  name                = format("%s-vnet", local.project)
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

# Registry
data "azurerm_container_registry" "container_registry" {
  name                = join("", [replace(var.prefix, "-", ""), var.env_short, "arc"])
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

# For locals
data "azurerm_container_group" "spid_testenv" {
  count               = var.enable_spid_test ? 1 : 0
  name                = format("%s-spid-testenv", local.project)
  resource_group_name = data.azurerm_resource_group.rg_spid_testenv.name
}

# App services

data "azurerm_app_service" "spid_login" {
  name                = format("%s-spid-login", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_app_service" "ade_aa_mock" {
  count  = var.enable_ade_aa_mock ? 1 : 0
  name                = format("%s-ade-aa-mock", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

# Azure Subnets
data "azurerm_subnet" "subnet_api" {
  name                 = format("%s-api-subnet", local.project)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

# Key Vault
data "azurerm_key_vault" "key_vault" {
  name                       = format("%s-kv", local.project)
  resource_group_name        = data.azurerm_resource_group.rg_sec.name
}

# DNS
data "azurerm_dns_cname_record" "frontend" {
  count               = var.enable_custom_dns ? 1 : 0
  name                = "portal"
  resource_group_name = data.azurerm_resource_group.rg_public.name
  zone_name           = var.dns_zone_prefix != null ? data.azurerm_dns_zone.public[0].name : data.azurerm_dns_zone.public_uat[0].name
}

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

# pkcs12
data "pkcs12_from_pem" "jwt_pkcs12" {
  password        = ""
  cert_pem        = tls_self_signed_cert.jwt_self.cert_pem
  private_key_pem = tls_private_key.jwt.private_key_pem
}