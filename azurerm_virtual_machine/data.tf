data "azurerm_public_ip" "PIP" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet_data" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet
  resource_group_name  = var.resource_group_name
}

data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "admin_user" {
  name         = var.secret_user
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "admin_pass" {
  name         = var.secret_pass
  key_vault_id = data.azurerm_key_vault.keyvault.id
}


# data "azurerm_network_security_group" "nsg_assc" {
#   name                = var.nsg_name
#   resource_group_name = var.resource_group_name
# }
