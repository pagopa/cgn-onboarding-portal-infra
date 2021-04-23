
resource "azurerm_api_management_api" "this" {
  name                  = format("%s-backend-api", var.project)
  resource_group_name   = var.resource_group_name
  api_management_name   = var.api_management_name
  revision              = "1"
  display_name          = "BACKEND"
  subscription_required = false
  path                  = "api/v1"
  protocols             = ["http", "https"]
  service_url           = var.backend_api_service_url
  import {
    content_format = var.content_format
    content_value  = var.content_value
  }
}


resource "azurerm_api_management_api_policy" "this" {
  api_name            = azurerm_api_management_api.this.name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name

  xml_content = var.xml_content
}
