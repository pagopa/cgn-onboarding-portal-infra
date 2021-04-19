resource "azurerm_resource_group" "rg_sonarqube" {
  count    = var.enable_sonarqube ? 1 : 0
  name     = format("%s-sonarqube-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_storage_account" "sonarqube_storage_account" {
  count                     = var.enable_sonarqube ? 1 : 0
  name                      = replace(format("%s-sa-sq", local.project), "-", "")
  resource_group_name       = azurerm_resource_group.rg_sonarqube[0].name
  location                  = var.location
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  account_tier              = "Standard"

  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "sonarqube_storage_share" {
  count = var.enable_sonarqube ? 1 : 0
  name  = format("%s-sonarqube-share", local.project)

  storage_account_name = azurerm_storage_account.sonarqube_storage_account[0].name

  quota = 16
}

resource "azurerm_storage_share" "caddy_storage_share" {
  count = var.enable_sonarqube ? 1 : 0
  name  = format("%s-sonarqube-caddy-share", local.project)

  storage_account_name = azurerm_storage_account.sonarqube_storage_account[0].name

  quota = 1
}

resource "azurerm_container_group" "sonarqube" {
  count               = var.enable_sonarqube ? 1 : 0
  name                = format("%s-sonarqube", local.project)
  location            = azurerm_resource_group.rg_sonarqube[0].location
  resource_group_name = azurerm_resource_group.rg_sonarqube[0].name
  ip_address_type     = "public"
  dns_name_label      = format("%s-sonarqube", local.project)
  os_type             = "Linux"

  container {
    name   = "sonarqube"
    image  = "sonarqube:8-community"
    cpu    = "1"
    memory = "3"

    ports {
      port     = 9000
      protocol = "TCP"
    }

    environment_variables = {
      SONAR_SEARCH_JAVAADDITIONALOPTS = "-Dnode.store.allow_mmap=false"
    }

    readiness_probe {
      http_get {
        path   = "/api/system/status"
        port   = 9000
        scheme = "Http"
      }
      initial_delay_seconds = 30
      timeout_seconds       = 4
    }

    liveness_probe {
      http_get {
        path   = "/api/system/status"
        port   = 9000
        scheme = "Http"
      }
      initial_delay_seconds = 900
      timeout_seconds       = 4
    }

    volume {
      mount_path = "/opt/sonarqube/data"
      name       = "sonarqube-data"
      read_only  = false
      share_name = azurerm_storage_share.sonarqube_storage_share[0].name

      storage_account_key  = azurerm_storage_account.sonarqube_storage_account[0].primary_access_key
      storage_account_name = azurerm_storage_account.sonarqube_storage_account[0].name
    }
  }

  container {
    name     = "caddy-ssl-server"
    image    = "caddy:2"
    cpu      = "0.5"
    memory   = "0.5"
    commands = ["caddy", "reverse-proxy", "--from", "${format("%s-sonarqube", local.project)}.${var.location}.azurecontainer.io", "--to", "localhost:9000"]

    ports {
      port     = 443
      protocol = "TCP"
    }

    ports {
      port     = 80
      protocol = "TCP"
    }

    volume {
      mount_path = "/data"
      name       = "caddy-data"
      read_only  = false
      share_name = azurerm_storage_share.caddy_storage_share[0].name

      storage_account_key  = azurerm_storage_account.sonarqube_storage_account[0].primary_access_key
      storage_account_name = azurerm_storage_account.sonarqube_storage_account[0].name
    }
  }

  tags = var.tags
}
