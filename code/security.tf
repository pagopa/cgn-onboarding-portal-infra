data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg_sec" {
  name     = format("%s-sec-rg", local.project)
  location = var.location
  tags     = var.tags
}

# User managed identity
#

resource "azurerm_user_assigned_identity" "main" {
  resource_group_name = azurerm_resource_group.rg_sec.name
  location            = azurerm_resource_group.rg_sec.location
  name                = format("%s-user-identity", local.project)

  tags = var.tags
}


# Create Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                        = format("%s-kv", local.project)
  location                    = azurerm_resource_group.rg_sec.location
  resource_group_name         = azurerm_resource_group.rg_sec.name
  enabled_for_disk_encryption = false
  enable_rbac_authorization   = false
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  tags                        = var.tags
  sku_name                    = "standard"

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow" #tfsec:ignore:AZU020
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
        "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"
      ]

      storage_permissions = []
    },
    {
      tenant_id      = data.azurerm_client_config.current.tenant_id
      object_id      = module.apim.principal_id
      application_id = ""

      key_permissions         = []
      secret_permissions      = ["Get", "List"]
      certificate_permissions = ["Get", "List"]
      storage_permissions     = []
    },
    {
      tenant_id      = azurerm_user_assigned_identity.main.tenant_id
      object_id      = azurerm_user_assigned_identity.main.principal_id
      application_id = ""

      key_permissions         = ["Get", "List"]
      secret_permissions      = ["Get", "List"]
      certificate_permissions = ["Get", "List"]
      storage_permissions     = []
    },
    {
      application_id = ""
      tenant_id      = data.azurerm_client_config.current.tenant_id
      object_id      = var.ad_key_vault_group_object_id

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

resource "tls_private_key" "jwt" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "jwt_self" {
  allowed_uses = [
    "crl_signing",
    "data_encipherment",
    "digital_signature",
    "key_agreement",
    "cert_signing",
    "key_encipherment"
  ]
  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.jwt.private_key_pem
  validity_period_hours = 8640
  subject {
    common_name = "apim"
  }
}

resource "pkcs12_from_pem" "jwt_pkcs12" {
  password        = ""
  cert_pem        = tls_self_signed_cert.jwt_self.cert_pem
  private_key_pem = tls_private_key.jwt.private_key_pem
}

resource "tls_private_key" "spid" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "spid_self" {
  allowed_uses = [
    "crl_signing",
    "data_encipherment",
    "digital_signature",
    "key_agreement",
    "cert_signing",
    "key_encipherment",
    "server_auth",
    "code_signing",
    "any_extended"
  ]
  early_renewal_hours   = 24
  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.spid.private_key_pem
  validity_period_hours = 8760
  subject {
    common_name         = "hub-spid-login-ms"
    organization        = "Acme Inc."
    organizational_unit = "IT Department"
    locality            = "City"
    province            = "State"
    country             = "IT"
  }
}
