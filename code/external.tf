resource "azurerm_resource_group" "rg_external" {
  name     = format("%s-external-rg", local.project)
  location = var.location
  tags     = var.tags

}

# Since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = format("%s-appgw-be-address-pool", local.project)
  frontend_port_name             = format("%s-appgw-fe-port", local.project)
  frontend_ip_configuration_name = format("%s-appgw-fe-ip-configuration", local.project)
  http_setting_name              = format("%s-appgw-be-http-settings", local.project)
  listener_name                  = format("%s-appgw-fe-http-settings", local.project)
  request_routing_rule_name      = format("%s-appgw-reqs-routing-rule", local.project)
}

resource "azurerm_application_gateway" "api_gateway" {
  name                = format("%s-api-gateway", local.project)
  resource_group_name = azurerm_resource_group.rg_external.name
  location            = azurerm_resource_group.rg_external.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = format("%s-appgw-gw-ip-configuration", local.project)
    subnet_id = module.subnet_public.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
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
      status_code = []
    }
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}
