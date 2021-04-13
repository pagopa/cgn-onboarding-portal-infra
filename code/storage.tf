resource "azurerm_resource_group" "rg_storage" {
  name     = format("%s-storage-rg", local.project)
  location = var.location

  tags = var.tags
}

module "storage_account" {
  source = "../modules/storage_account"

  name            = format("%s-sa", local.project)
  versioning_name = format("%s-sa-versioning", local.project)
  lock_name       = format("%s-sa-lock", local.project)

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Hot"
  resource_group_name      = azurerm_resource_group.rg_storage.name
  location                 = var.location
  lock                     = var.storage_account_lock != null
  lock_scope               = var.storage_account_lock.scope
  lock_level               = var.storage_account_lock.lock_level
  lock_notes               = var.storage_account_lock.notes

  tags = var.tags
}

# Containers
resource "azurerm_storage_container" "user_documents" {
  name                  = format("%s-sc-user-documents", local.project)
  storage_account_name  = module.storage_account.name
  container_access_type = "blob"
}


module "storage_account_website" {
  source = "../modules/storage_account"

  name            = format("%s-sa-website", local.project)
  versioning_name = format("%s-sa-website-versioning", local.project)
  lock_name       = format("%s-sa-website-lock", local.project)

  enable_static_website    = true
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Hot"
  resource_group_name      = azurerm_resource_group.rg_storage.name
  location                 = var.location
  lock                     = var.storage_account_website_lock != null
  lock_scope               = var.storage_account_website_lock.scope
  lock_level               = var.storage_account_website_lock.lock_level
  lock_notes               = var.storage_account_website_lock.notes
  tags                     = var.tags
}
