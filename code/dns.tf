resource "azurerm_resource_group" "rg_dns" {
  name     = format("%s-dns-rg", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_dns_zone" "parent" {
  name                = var.external_domain
  resource_group_name = var.parent_resource_group_name
}

resource "azurerm_dns_zone" "this" {
  name                = "${var.prefix}.${var.external_domain}"
  resource_group_name = azurerm_resource_group.rg_dns.name

  tags = var.tags
}

resource "azurerm_dns_ns_record" "this" {
  name                = var.prefix
  records             = azurerm_dns_zone.this.name_servers
  resource_group_name = var.parent_resource_group_name
  ttl                 = 300
  zone_name           = data.azurerm_dns_zone.parent.name

  tags = var.tags
}

resource "azurerm_dns_a_record" "api" {
  name                = "api"
  records             = [azurerm_public_ip.apigateway_public_ip.ip_address]
  resource_group_name = azurerm_resource_group.rg_dns.name
  ttl                 = 300
  zone_name           = azurerm_dns_zone.this.name

  tags = var.tags
}

resource "azurerm_dns_cname_record" "frontend" {
  name                = var.prefix
  record              = module.cdn_portal_frontend.hostname
  resource_group_name = data.azurerm_dns_zone.parent.resource_group_name
  ttl                 = 300
  zone_name           = data.azurerm_dns_zone.parent.name

  tags = var.tags
}
