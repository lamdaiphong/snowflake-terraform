data "azurerm_key_vault" "current" {
  name = "snowflake2024"
  resource_group_name = "master"
}

data "azurerm_key_vault_secrets" "current" {
  key_vault_id = data.azurerm_key_vault.current.id
}

data "azurerm_key_vault_secret" "current" {
  for_each     = toset(data.azurerm_key_vault_secrets.current.names)
  name         = each.key
  key_vault_id = data.azurerm_key_vault.current.id
  # nonsensitive(data.azurerm_key_vault_secret.current["certificate-authority"].value) => example of getting a secret
}

