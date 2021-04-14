
# Create an App Service Plan with Linux
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Define Linux as Host OS
  kind     = "Linux"
  reserved = true # Mandatory for Linux plans

  # Choose size
  sku {
    tier     = var.sku.tier
    size     = var.sku.size
    capacity = var.sku.capacity
  }

  tags = var.tags
}

# Create an Azure Web App for Containers in that App Service Plan
resource "azurerm_app_service" "app_service" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  https_only          = true

  app_settings = var.app_settings

  # Configure Docker Image to load on start
  site_config {
    always_on         = var.always_on
    linux_fx_version  = var.linux_fx_version
    app_command_line  = var.app_command_line
    min_tls_version   = "1.2"
    ftps_state        = "Disabled"
    health_check_path = var.health_check_path != null ? var.health_check_path : null

    dynamic "ip_restriction" {
      for_each = var.allowed_subnets
      iterator = subnet

      content {
        ip_address                = null
        virtual_network_subnet_id = subnet.value
      }
    }

    dynamic "ip_restriction" {
      for_each = var.allowed_ips
      iterator = ip

      content {
        ip_address                = ip.value
        virtual_network_subnet_id = null
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      "site_config[0].linux_fx_version", # deployments are made outside of Terraform
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_service_virtual_network_swift_connection" {
  count = var.subnet_id == null ? 0 : 1

  app_service_id = azurerm_app_service.app_service.id
  subnet_id      = var.subnet_id
}
