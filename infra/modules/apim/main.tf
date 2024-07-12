
resource "azurerm_api_management" "this" {
  name                      = var.resource_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  publisher_name            = var.publisher_name
  publisher_email           = var.publisher_email
  notification_sender_email = var.notification_sender_email
  sku_name                  = var.sku_name

  identity {
    type = "SystemAssigned"
  }

  virtual_network_type = "Internal"
  virtual_network_configuration {
    subnet_id = var.subnet_id
  }

  tags = var.tags
}

resource "azurerm_api_management_policy" "this" {
  api_management_id = azurerm_api_management.this.id
  xml_content       = var.xml_content
}