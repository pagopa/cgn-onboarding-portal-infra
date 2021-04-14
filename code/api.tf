resource "azurerm_resource_group" "rg_api" {
  name     = format("%s-api-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_container_registry" "container_registry" {
  name                = join("", [replace(var.prefix, "-", ""), var.env_short, "arc"])
  resource_group_name = azurerm_resource_group.rg_api.name
  location            = azurerm_resource_group.rg_api.location
  sku                 = var.sku_container_registry


  dynamic "retention_policy" {
    for_each = var.sku_container_registry == "Premium" ? [var.retention_policy_acr] : []
    content {
      days    = retention_policy.value["days"]
      enabled = retention_policy.value["enabled"]
    }
  }

  tags = var.tags
}

resource "azurerm_app_service_plan" "main" {
  name                = format("%s-asp", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_api.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}


module "portal_backend_1" {
  source = "../modules/app_service"

  name                = format("%s-portal-backend1", local.project)
  plan_name           = format("%s-plan-portal-backend1", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 443

    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.container_registry.admin_password

    # DNS configuration to use private endpoint
    WEBSITE_DNS_SERVER     = "168.63.129.16"
    WEBSITE_VNET_ROUTE_ALL = 1

    # These are app specific environment variables
    "SPRING_DATASOURCE_URL"      = ""
    "SPRING_DATASOURCE_USERNAME" = ""
    "SPRING_DATASOURCE_PASSWORD" = ""
  }

  #linux_fx_version = "DOCKER|/${azurerm_container_registry.container_registry.login_server}/cgn-onboarding-portal-backend:latest"
  always_on = "true"

  allowed_subnets = [module.subnet_public.id]
  allowed_ips     = []

  subnet_id = module.subnet_api.id

}

# TODO search api
