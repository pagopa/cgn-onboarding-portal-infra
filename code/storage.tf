resource "azurerm_resource_group" "rg_storage" {
  name     = format("%s-storage-rg", local.project)
  location = var.location

  tags = var.tags
}

module "storage_account" {
  source = "../modules/storage_account"

  name            = replace(format("%s-sa", local.project), "-", "")
  versioning_name = format("%s-sa-versioning", local.project)
  lock_name       = format("%s-sa-lock", local.project)

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Hot"
  resource_group_name      = azurerm_resource_group.rg_storage.name
  location                 = var.location
  lock                     = var.storage_account_lock != null
  lock_scope               = var.storage_account_lock != null ? var.storage_account_lock.scope : null
  lock_level               = var.storage_account_lock != null ? var.storage_account_lock.lock_level : "CanNotDelete"
  lock_notes               = var.storage_account_lock != null ? var.storage_account_lock.notes : null

  tags = var.tags
}

# Containers
resource "azurerm_storage_container" "user_documents" {
  name                  = "userdocuments"
  storage_account_name  = module.storage_account.name
  container_access_type = "blob"
}


module "storage_account_website" {
  source = "../modules/storage_account"

  name            = replace(format("%s-sa-ws", local.project), "-", "")
  versioning_name = format("%s-sa-ws-versioning", local.project)
  lock_name       = format("%s-sa-ws-lock", local.project)

  enable_static_website    = true
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Hot"
  resource_group_name      = azurerm_resource_group.rg_storage.name
  location                 = var.location
  lock                     = var.storage_account_website_lock != null
  lock_scope               = var.storage_account_website_lock != null ? var.storage_account_website_lock.scope : null
  lock_level               = var.storage_account_website_lock != null ? var.storage_account_website_lock.lock_level : "CanNotDelete"
  lock_notes               = var.storage_account_website_lock != null ? var.storage_account_website_lock.notes : null
  tags                     = var.tags
}
