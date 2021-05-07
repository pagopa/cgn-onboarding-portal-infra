resource "azurerm_resource_group" "rg_public" {
  name     = format("%s-public-rg", local.project)
  location = var.location
  tags     = var.tags

}

# Since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name       = format("%s-appgw-be-address-pool", local.project)
  frontend_http_port_name         = format("%s-appgw-fe-http-port", local.project)
  frontend_https_port_name        = format("%s-appgw-fe-https-port", local.project)
  frontend_ip_configuration_name  = format("%s-appgw-fe-ip-configuration", local.project)
  http_setting_name               = format("%s-appgw-be-http-settings", local.project)
  http_listener_name              = format("%s-appgw-fe-http-settings", local.project)
  https_listener_name             = format("%s-appgw-fe-https-settings", local.project)
  http_request_routing_rule_name  = format("%s-appgw-http-reqs-routing-rule", local.project)
  https_request_routing_rule_name = format("%s-appgw-https-reqs-routing-rule", local.project)
  acme_le_ssl_cert_name           = format("%s-appgw-acme-le-ssl-cert", local.project)
  http_to_https_redirect_rule     = format("%s-appgw-http-to-https-redirect-rule", local.project)
}

resource "azurerm_application_gateway" "api_gateway" {
  name                = format("%s-api-gateway", local.project)
  resource_group_name = azurerm_resource_group.rg_public.name
  location            = azurerm_resource_group.rg_public.location

  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  enable_http2 = true

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401S"
  }

  gateway_ip_configuration {
    name      = format("%s-appgw-gw-ip-configuration", local.project)
    subnet_id = module.subnet_public.id
  }

  frontend_port {
    name = local.frontend_http_port_name
    port = 80
  }

  frontend_port {
    name = local.frontend_https_port_name
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.apigateway_public_ip.id
  }

  backend_address_pool {
    name         = local.backend_address_pool_name
    fqdns        = [trim(azurerm_private_dns_a_record.private_dns_a_record_api.fqdn, ".")]
    ip_addresses = []
  }

  backend_http_settings {
    name                  = local.http_setting_name
    host_name             = trim(azurerm_private_dns_a_record.private_dns_a_record_api.fqdn, ".")
    cookie_based_affinity = "Disabled"
    path                  = ""
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
    probe_name            = "probe-apim"
  }

  probe {
    host                                      = trim(azurerm_private_dns_a_record.private_dns_a_record_api.fqdn, ".")
    minimum_servers                           = 0
    name                                      = "probe-apim"
    path                                      = "/status-0123456789abcdef"
    pick_host_name_from_backend_http_settings = false
    protocol                                  = "Http"
    timeout                                   = 30
    interval                                  = 30
    unhealthy_threshold                       = 3

    match {
      status_code = ["200-399"]
    }
  }

  http_listener {
    name                           = local.http_listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_http_port_name
    protocol                       = "Http"
  }

  http_listener {
    name                           = local.https_listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_https_port_name
    protocol                       = "Https"
    ssl_certificate_name           = var.app_gateway_certificate_name
    require_sni                    = true
    host_name                      = var.app_gateway_host_name
  }

  request_routing_rule {
    name                       = local.http_request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.http_listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  request_routing_rule {
    name                       = local.https_request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.https_listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  dynamic "ssl_certificate" {
    for_each = var.enable_custom_dns ? [true] : []
    content {
      name                = data.azurerm_key_vault_secret.app_gw_cert[0].name
      key_vault_secret_id = trimsuffix(data.azurerm_key_vault_secret.app_gw_cert[0].id, data.azurerm_key_vault_secret.app_gw_cert[0].version)
    }

  }

  redirect_configuration {
    name                 = local.http_to_https_redirect_rule
    redirect_type        = "Permanent"
    target_listener_name = local.https_listener_name
    include_path         = true
    include_query_string = true
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }


  waf_configuration {
    enabled                  = true
    firewall_mode            = "Detection"
    rule_set_type            = "OWASP"
    rule_set_version         = "3.1"
    request_body_check       = true
    file_upload_limit_mb     = 100
    max_request_body_size_kb = 128
  }

  autoscale_configuration {
    min_capacity = var.app_gateway_min_capacity
    max_capacity = var.app_gateway_max_capacity
  }
}
