# Define the DNS zones for all subscriptions

resource "azurerm_private_dns_zone" "azure_api_net" {
  name                = "azure-api.net"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone" "management_azure_api_net" {
  name                = "management.azure-api.net"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone" "scm_azure_api_net" {
  name                = "scm.azure-api.net"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

# Define the A Records for APIMv2

resource "azurerm_private_dns_a_record" "apim_azure_api_net" {
  name                = module.apim_v2.name
  zone_name           = azurerm_private_dns_zone.azure_api_net.name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_config.dns_default_ttl_sec
  records             = [module.apim_v2.private_ip_addresses[0]]

  tags = var.tags
}

resource "azurerm_private_dns_a_record" "apim_management_azure_api_net" {
  name                = module.apim_v2.name
  zone_name           = azurerm_private_dns_zone.management_azure_api_net.name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_config.dns_default_ttl_sec
  records             = [module.apim_v2.private_ip_addresses[0]]

  tags = var.tags
}

resource "azurerm_private_dns_a_record" "apim_scm_azure_api_net" {
  name                = module.apim_v2.name
  zone_name           = azurerm_private_dns_zone.scm_azure_api_net.name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_config.dns_default_ttl_sec
  records             = [module.apim_v2.private_ip_addresses[0]]

  tags = var.tags
}

# Link A Records into the VNet

resource "azurerm_private_dns_zone_virtual_network_link" "azure_api_link" {
  name                  = format("%s-vnet", local.project)
  resource_group_name   = data.azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.azure_api_net.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}


resource "azurerm_private_dns_zone_virtual_network_link" "management_api_link" {
  name                  = format("%s-vnet", local.project)
  resource_group_name   = data.azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.management_azure_api_net.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "scm_apim_link" {
  name                  = format("%s-vnet", local.project)
  resource_group_name   = data.azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.scm_azure_api_net.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}