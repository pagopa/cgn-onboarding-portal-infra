data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg_sec" {
  name     = format("%s-sec-rg", local.project)
  location = var.location
  tags     = var.tags
}

# Create Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                        = format("%s-kv", local.project)
  location                    = azurerm_resource_group.rg_sec.location
  resource_group_name         = azurerm_resource_group.rg_sec.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  tags                        = var.tags
  sku_name                    = "standard"

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }

  access_policy = [
    {
      tenant_id      = data.azurerm_client_config.current.tenant_id
      object_id      = data.azurerm_client_config.current.object_id
      application_id = ""

      key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete",
        "Recover", "Backup", "Restore"
      ]

      secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Backup",
        "Restore"
      ]

      certificate_permissions = ["Get", "List", "Update", "Create", "Import",
        "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers",
        "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers"
      ]

      storage_permissions = []
    },
    {
      tenant_id      = data.azurerm_client_config.current.tenant_id
      object_id      = "3a65e356-ac25-45ab-9905-529b82b2c848"
      application_id = ""

      key_permissions         = []
      secret_permissions      = ["Get", "List"]
      certificate_permissions = ["Get", "List"]
      storage_permissions     = []
    },
    {
      application_id = ""
      tenant_id      = data.azurerm_client_config.current.tenant_id
      object_id      = "743bb651-0842-48ce-9908-11491e6bf054"

      key_permissions     = []
      secret_permissions  = []
      storage_permissions = []
      certificate_permissions = [
        "Get", "List", "Update", "Create", "Import",
        "Delete", "Restore", "Purge", "Recover"
      ]
    },
  ]
}
