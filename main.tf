resource "random_string" "ns" {
  special = false
  upper   = false
  length  = 12
}

data "azurerm_resource_group" "hw-rg" {
  name = var.hw-rg
}

data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault" "hw-kv" {
  name                = var.hw-kv
  location            = data.azurerm_resource_group.hw-rg.location
  resource_group_name = data.azurerm_resource_group.hw-rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "premium"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "list",
      "get",
    ]

    secret_permissions = [
      "list",
      "set",
      "get",
      "delete",
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.user_principal_id

    key_permissions = [
      "create",
      "list",
      "get",
    ]

    secret_permissions = [
      "list",
      "set",
      "get",
      "delete",
    ]
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_key_vault_secret" "hw-ks" {
  name         = "StrongestAvenger"
  value        = var.StrongestAvenger
  key_vault_id = azurerm_key_vault.hw-kv.id

  tags = {
    environment = "Production"
  }
}