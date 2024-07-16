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

data "azurerm_key_vault_certificate" "app_gw_platform" {
  name         = var.app_gateway_certificate_name
  key_vault_id = module.key_vault.id
}


# Application gateway: Multilistener configuraiton
module "app_gw" {
  source = "git::https://github.com/pagopa/azurerm.git//app_gateway?ref=v2.0.2"

  resource_group_name = azurerm_resource_group.rg_public.name
  location            = azurerm_resource_group.rg_public.location
  name                = format("%s-api-gateway", local.project)

  # SKU
  sku_name = var.app_gateway_sku_name
  sku_tier = var.app_gateway_sku_tier

  # Networking
  subnet_id    = module.subnet_public.id
  public_ip_id = azurerm_public_ip.apigateway_public_ip.id

  # Configure backends
  backends = {
    apim = {
      protocol                    = "Http"
      host                        = local.apim_hostname
      port                        = 80
      ip_addresses                = null
      fqdns                       = [local.apim_hostname]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apim"
      request_timeout             = 8
      pick_host_name_from_backend = false
    }
  }

  ssl_profiles = [{
    name                             = format("%s-ssl-profile", local.project)
    trusted_client_certificate_names = null
    verify_client_cert_issuer_dn     = false
    ssl_policy = {
      disabled_protocols = []
      policy_type        = "Custom"
      policy_name        = "" # with Custom type set empty policy_name (not required by the provider)
      cipher_suites = [
        "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
        "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
        "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
        "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA"
      ]
      min_protocol_version = "TLSv1_2"
    }
  }]

  trusted_client_certificates = []

  # Configure listeners
  listeners = {
    api = {
      protocol           = "Https"
      host               = var.app_gateway_host_name
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_platform.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_platform.version}",
          ""
        )
      }
    }
  }

  # maps listener to backend
  routes = {
    api = {
      listener              = "api"
      backend               = "apim"
      rewrite_rule_set_name = null
    }
  }

  rewrite_rule_sets = []

  # TLS
  identity_ids = [azurerm_user_assigned_identity.main.id]

  waf_enabled = var.app_gateway_sku_tier == "WAF_v2" ? true : false

  # WAF
  waf_disabled_rule_group = var.app_gateway_sku_tier == "WAF_v2" ? [
    {
      rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
      rules           = ["920300", ]
    }
  ] : []

  # Scaling
  app_gateway_min_capacity = var.app_gateway_min_capacity
  app_gateway_max_capacity = var.app_gateway_max_capacity

  # Alerts app gateway
  alerts_enabled = var.app_gateway_alerts_enabled

  action = [
    {
      action_group_id    = azurerm_monitor_action_group.p0action.id
      webhook_properties = null
    },
  ]

  # metrics docs
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftnetworkapplicationgateways
  monitor_metric_alert_criteria = {

    compute_units_usage = {
      description   = "Abnormal compute units usage, probably an high traffic peak"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Average"
          metric_name              = "ComputeUnits"
          operator                 = "GreaterOrLessThan"
          alert_sensitivity        = "Low" # todo after api app migration change to High
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }

    backend_pools_status = {
      description   = "One or more backend pools are down, check Backend Health on Azure portal"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 0
      auto_mitigate = true

      criteria = [
        {
          aggregation = "Average"
          metric_name = "UnhealthyHostCount"
          operator    = "GreaterThan"
          threshold   = 0
          dimension   = []
        }
      ]
      dynamic_criteria = []
    }

    response_time = {
      description   = "Backends response time is too high"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Average"
          metric_name              = "BackendLastByteResponseTime"
          operator                 = "GreaterThan"
          alert_sensitivity        = "High"
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }

    total_requests = {
      description   = "Traffic is raising"
      frequency     = "PT5M"
      window_size   = "PT15M"
      severity      = 3
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Total"
          metric_name              = "TotalRequests"
          operator                 = "GreaterThan"
          alert_sensitivity        = "Medium"
          evaluation_total_count   = 1
          evaluation_failure_count = 1
          dimension                = []
        }
      ]
    }

    failed_requests = {
      description   = "Abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Total"
          metric_name              = "FailedRequests"
          operator                 = "GreaterThan"
          alert_sensitivity        = "High"
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }

  }

  tags = var.tags
}