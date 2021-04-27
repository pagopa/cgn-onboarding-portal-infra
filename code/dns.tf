

resource "azurerm_dns_zone" "public" {
  count               = (var.dns_zone_prefix == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_prefix, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_public.name

  tags = var.tags
}

resource "azurerm_dns_a_record" "api" {
  count               = terraform.workspace == "prod" ? 1 : 0
  name                = "api"
  records             = [azurerm_public_ip.apigateway_public_ip.ip_address]
  resource_group_name = azurerm_resource_group.rg_public.name
  ttl                 = 300
  zone_name           = azurerm_dns_zone.public[0].name

  tags = var.tags
}

resource "azurerm_dns_cname_record" "frontend" {
  count               = terraform.workspace == "prod" ? 1 : 0
  name                = "portal"
  record              = module.cdn_portal_frontend.hostname
  resource_group_name = azurerm_resource_group.rg_public.name
  ttl                 = 300
  zone_name           = azurerm_dns_zone.public[0].name

  tags = var.tags
}
