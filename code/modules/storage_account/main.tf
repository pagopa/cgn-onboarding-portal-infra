

resource "azurerm_storage_account" "storage_account" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  access_tier               = var.access_tier
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  allow_blob_public_access  = var.allow_blob_public_access

  dynamic "static_website" {
    for_each = var.enable_static_website ? [{}] : []
    content {
      index_document     = var.index_path
      error_404_document = var.custom_404_path
    }
  }

  dynamic "blob_properties" {
    for_each = var.soft_delete_retention != null || length(var.cors_rule) != 0 ? [{}] : []
    content {
      dynamic "delete_retention_policy" {
        for_each = var.soft_delete_retention != null ? [{}] : []
        content {
          days = var.soft_delete_retention
        }
      }
      dynamic "cors_rule" {
        for_each = var.cors_rule
        content {
          allowed_origins    = cors_rule.value.allowed_origins
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_headers    = cors_rule.value.allowed_headers
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
    }
  }


  dynamic "network_rules" {
    for_each = var.network_rules == null ? [] : [var.network_rules]

    content {
      default_action             = length(network_rules.value["ip_rules"]) == 0 && length(network_rules.value["virtual_network_subnet_ids"]) == 0 ? network_rules.value["default_action"] : "Deny"
      bypass                     = network_rules.value["bypass"]
      ip_rules                   = network_rules.value["ip_rules"]
      virtual_network_subnet_ids = network_rules.value["virtual_network_subnet_ids"]
    }
  }

  tags = var.tags
}

# Enable advanced threat protection
resource "azurerm_advanced_threat_protection" "advanced_threat_protection" {
  target_resource_id = azurerm_storage_account.storage_account.id
  enabled            = true
}



# this is a tempory implementation till an official one will be released:
# https://github.com/terraform-providers/terraform-provider-azurerm/issues/8268

resource "azurerm_template_deployment" "versioning" {
  depends_on          = [azurerm_storage_account.storage_account]
  name                = var.versioning_name
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  parameters = {
    "storageAccount" = azurerm_storage_account.storage_account.name
  }

  template_body = <<DEPLOY
        {
            "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
            "contentVersion": "1.0.0.0",
            "parameters": {
                "storageAccount": {
                    "type": "string",
                    "metadata": {
                        "description": "Storage Account Name"}
                }
            },
            "variables": {},
            "resources": [
                {
                    "type": "Microsoft.Storage/storageAccounts/blobServices",
                    "apiVersion": "2019-06-01",
                    "name": "[concat(parameters('storageAccount'), '/default')]",
                    "properties": {
                        "IsVersioningEnabled": ${var.enable_versioning}
                    }
                }
            ]
        }
    DEPLOY
}

resource "azurerm_management_lock" "management_lock" {
  count      = var.lock ? 1 : 0
  name       = var.resource_group_name
  scope      = var.lock_scope
  lock_level = var.lock_level
  notes      = var.lock_notes
}

