output "azurerm_resource_group_name" {
  value = "${data.azurerm_resource_group.hw-rg.name}"
}

output "azurerm_key_vault_name" {
  value = "${azurerm_key_vault.hw-kv.name}"
}