resource "azurerm_resource_group" "rg_spid_testenv" {
  count    = terraform.workspace == "prod" ? 0 : 1
  name     = format("%s-spid-testenv-rg", local.project)
  location = var.location

  tags = var.tags
}


resource "azurerm_storage_account" "spid_testenv_storage_account" {
  count    = terraform.workspace == "prod" ? 0 : 1
  name                      = replace(format("%s-sa-st", local.project), "-", "")
  resource_group_name       = azurerm_resource_group.rg_spid_testenv[0].name
  location                  = var.location
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  account_tier              = "Standard"

  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "spid_testenv_storage_share" {
  count    = terraform.workspace == "prod" ? 0 : 1
  name  = format("%s-spid-testenv-share", local.project)

  storage_account_name = azurerm_storage_account.spid_testenv_storage_account[0].name

  quota = 1
}

resource "azurerm_storage_share" "spid_testenv_caddy_storage_share" {
  count    = terraform.workspace == "prod" ? 0 : 1
  name  = format("%s-spid-testenv-caddy-share", local.project)

  storage_account_name = azurerm_storage_account.spid_testenv_storage_account[0].name

  quota = 1
}

resource "azurerm_container_group" "spid_testenv" {
  count    = terraform.workspace == "prod" ? 0 : 1
  name                = format("%s-spid-testenv", local.project)
  location            = azurerm_resource_group.rg_spid_testenv[0].location
  resource_group_name = azurerm_resource_group.rg_spid_testenv[0].name
  ip_address_type     = "public"
  dns_name_label      = format("%s-spid-testenv", local.project)
  os_type             = "Linux"

  container {
    name   = "spid-testenv2"
    image  = "italia/spid-testenv2:1.1.0"
    cpu    = "0.5"
    memory = "0.5"

    ports {
      port     = 8088
      protocol = "TCP"
    }

    environment_variables = {

    }

    readiness_probe {
      http_get {
        path   = "/"
        port   = 8088
        scheme = "Http"
      }
      initial_delay_seconds = 30
      timeout_seconds       = 4
    }

    liveness_probe {
      http_get {
        path   = "/"
        port   = 8088
        scheme = "Http"
      }
      initial_delay_seconds = 900
      timeout_seconds       = 4
    }

    volume {
      mount_path = "/app/conf"
      name       = "spid-testenv-conf"
      read_only  = false
      share_name = azurerm_storage_share.spid_testenv_storage_share[0].name

      storage_account_key  = azurerm_storage_account.spid_testenv_storage_account[0].primary_access_key
      storage_account_name = azurerm_storage_account.spid_testenv_storage_account[0].name
    }

  }

  container {
    name     = "caddy-ssl-server"
    image    = "caddy:2"
    cpu      = "0.5"
    memory   = "0.5"
    commands = ["caddy", "reverse-proxy", "--from", "${format("%s-spid-testenv", local.project)}.${var.location}.azurecontainer.io", "--to", "localhost:8088"]

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
      share_name = azurerm_storage_share.spid_testenv_caddy_storage_share[0].name

      storage_account_key  = azurerm_storage_account.spid_testenv_storage_account[0].primary_access_key
      storage_account_name = azurerm_storage_account.spid_testenv_storage_account[0].name
    }
  }

  tags = var.tags
}

resource "local_file" "spid_testenv_config" {
  filename = "./spid_testenv_conf/config.yaml"
  content = templatefile(
    "./spid_testenv_conf/config.yaml.tpl",
    {
      base_url                      = format("https://%s", azurerm_container_group.spid_testenv[0].fqdn)
      service_provider_metadata_url = format("http://%s/spid/v1/metadata", azurerm_public_ip.apigateway_public_ip.ip_address)
      # TODO change to APIM endpoint
  })
}

resource "null_resource" "upload_config_spid_testenv" {
  triggers = {
    "changes-in-config" : md5(local_file.spid_testenv_config.content)
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage file upload \
                --account-name ${azurerm_storage_account.spid_testenv_storage_account[0].name} \
                --account-key ${azurerm_storage_account.spid_testenv_storage_account[0].primary_access_key} \
                --share-name ${azurerm_storage_share.spid_testenv_storage_share[0].name} \
                --source "./spid_testenv_conf/config.yaml" \
                --path "config.yaml" && \
              az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID && \
              az container restart \
                --name ${azurerm_container_group.spid_testenv[0].name} \
                --resource-group  ${azurerm_resource_group.rg_spid_testenv[0].name}
          EOT
  }
}