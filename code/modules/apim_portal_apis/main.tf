data "template_file" "backend_api_swagger_json" {
  template = file("${path.module}/backend_api/openapi.json.tmpl")
  vars = {
    host = var.backend_api_host
  }
}


resource "azurerm_api_management_api" "backend_api" {
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
    content_format = "swagger-json"
    content_value  = data.template_file.backend_api_swagger_json.rendered
  }
}


resource "azurerm_api_management_api_policy" "backend_api_policy" {
  api_name            = azurerm_api_management_api.backend_api.name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name

  xml_content = file("${path.module}/backend_api/policy.xml")
}
