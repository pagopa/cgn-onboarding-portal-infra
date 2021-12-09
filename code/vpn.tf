## VPN subnet
module "vpn_snet" {
  count                                          = length(var.cidr_subnet_vpn) > 0 ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.3"
  name                                           = "GatewaySubnet"
  address_prefixes                               = var.cidr_subnet_vpn
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  service_endpoints                              = []
  enforce_private_link_endpoint_network_policies = true
}

data "azuread_application" "vpn_app" {
  count        = length(var.cidr_subnet_vpn) > 0 ? 1 : 0
  display_name = format("%s-app-vpn", local.project)
}

module "vpn" {
  count  = length(var.cidr_subnet_vpn) > 0 ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//vpn_gateway?ref=v2.0.7"

  name                = format("%s-vpn", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  sku                 = "VpnGw1"
  pip_sku             = "Basic"
  subnet_id           = module.vpn_snet[0].id

  vpn_client_configuration = [
    {
      address_space         = ["172.16.1.0/24"],
      vpn_client_protocols  = ["OpenVPN"],
      aad_audience          = data.azuread_application.vpn_app[0].application_id
      aad_issuer            = format("https://sts.windows.net/%s/", data.azurerm_subscription.current.tenant_id)
      aad_tenant            = format("https://login.microsoftonline.com/%s", data.azurerm_subscription.current.tenant_id)
      radius_server_address = null
      radius_server_secret  = null
      revoked_certificate   = []
      root_certificate      = []
    }
  ]

  tags = var.tags
}

## DNS Forwarder
module "dns_forwarder_snet" {
  count                                          = length(var.cidr_subnet_vpn) > 0 ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.3"
  name                                           = format("%s-dns-forwarder-snet", local.project)
  address_prefixes                               = var.cidr_subnet_dns_forwarder
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Storage",
  ]

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "dns_forwarder" {
  count               = length(var.cidr_subnet_vpn) > 0 ? 1 : 0
  source              = "git::https://github.com/pagopa/azurerm.git//dns_forwarder?ref=v2.0.8"
  name                = format("%s-dns-forwarder", local.project)
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  subnet_id           = module.dns_forwarder_snet[0].id

  tags = var.tags
}
