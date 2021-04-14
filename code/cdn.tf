resource "azurerm_resource_group" "rg_cdn" {
  name     = format("%s-cdn-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_cdn_profile" "cdn_profile_common" {
  name                = format("%s-cdn-common", local.project)
  resource_group_name = azurerm_resource_group.rg_cdn.name
  location            = var.location
  sku                 = "Standard_Microsoft"

  tags = var.tags
}

module "cdn_portal_frontend" {
  source = "../modules/cdn_endpoint"

  name = format("%s-cdnendpoint-frontend", local.project)
  # TODO
  origin_host_name    = module.storage_account_website.primary_web_host
  profile_name        = azurerm_cdn_profile.cdn_profile_common.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_cdn.name

  tags = var.tags
}



# TODO
//resource "azurerm_dns_cname_record" "dns_cname_portal_record" {
//  name                = "portal"
//  zone_name           = var.dns_zone.name
//  resource_group_name = azurerm_resource_group.rg_cdn.name
//  ttl                 = 300
//  record              = module.cdn_portal_frontend.hostname
//}
//
//resource "null_resource" "cdn_custom_domain" {
//  # needs az cli > 2.0.81
//  # see https://github.com/Azure/azure-cli/issues/12152
//  depends_on = [module.cdn_portal_frontend, azurerm_cdn_profile.cdn_profile_common]
//
//  provisioner "local-exec" {
//    command = <<EOT
//      az cdn custom-domain create \
//        --resource-group ${azurerm_resource_group.rg_cdn.name} \
//         ${module.cdn_portal_frontend.name} \
//        --profile-name ${azurerm_cdn_profile.cdn_profile_common.name} \
//        --name ${replace(trim(azurerm_dns_cname_record.dns_cname_portal_record.fqdn, "."), ".", "-")} \
//        --hostname ${trim(azurerm_dns_cname_record.dns_cname_portal_record.fqdn, ".")}
//      az cdn custom-domain enable-https \
//        --resource-group ${azurerm_resource_group.rg_cdn.name} \
//        --endpoint-name ${module.cdn_portal_frontend.name} \
//        --profile-name ${azurerm_cdn_profile.cdn_profile_common.name} \
//        --name ${replace(trim(azurerm_dns_cname_record.dns_cname_portal_record.fqdn, "."), ".", "-")}
//    EOT
//  }
//}
