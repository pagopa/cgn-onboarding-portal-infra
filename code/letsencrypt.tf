/*
provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

module "acme_le" {
  count                 = var.enable_custom_dns ? 1 : 0
  depends_on            = [azurerm_dns_zone.public]
  source                = "git::https://github.com/bitrockteam/caravan-acme-le?ref=v1.0.2"
  common_name           = azurerm_dns_zone.public[0].name
  dns_provider          = "azure"
  private_key           = tls_private_key.cert_private_key[0].private_key_pem
  azure_subscription_id = data.azurerm_client_config.current.subscription_id
  azure_tenant_id       = data.azurerm_client_config.current.tenant_id
  azure_resource_group  = azurerm_resource_group.rg_public.name
  azure_client_id       = data.azurerm_client_config.current.client_id
  azure_client_secret   = var.azure_client_secret
  azure_environment     = "public"
  from_csr              = false
}

resource "tls_private_key" "cert_private_key" {
  count     = var.enable_custom_dns ? 1 : 0
  algorithm = "RSA"
}
*/
