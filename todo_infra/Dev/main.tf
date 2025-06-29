module "resource_group" {
  for_each = var.resource_groups
  source   = "../../azurerm_resource_group"
  name     = each.value.name
  location = each.value.location
}

module "vnet" {
  depends_on          = [module.public_ip]
  for_each            = var.vnets
  source              = "../../azurerm_virtual_network"
  name                = each.value.name
  resource_group_name = var.resource_groups[each.value.rg].name
  location            = each.value.location
  address_space       = each.value.address_space
}

module "subnet" {
  depends_on           = [module.vnet]
  for_each             = var.subnets
  source               = "../../azurerm_subnet"
  name                 = each.value.name
  virtual_network_name = var.vnets[each.value.vnet].name
  resource_group_name  = var.resource_groups[each.value.rg].name
  address_prefixes     = each.value.address_prefixes
}

module "storage" {
  depends_on          = [module.resource_group]
  for_each            = var.storage_accounts
  source              = "../../azurerm_storage_account"
  storage_name        = each.value.name
  resource_group_name = var.resource_groups[each.value.rg].name
  location            = each.value.location
}

module "keyvault" {
  depends_on          = [module.resource_group]
  for_each            = var.keyvaults
  source              = "../../azurerm_keyvault"
  keyvault_name       = each.value.name
  resource_group_name = var.resource_groups[each.value.rg].name
  location            = each.value.location
}

module "keyvault_secrets" {
  depends_on = [module.keyvault]
  for_each   = var.keyvault_secrets
  source     = "../../azurerm_keyvault_secret"

  keyvault_name       = var.keyvaults[each.value.keyvault_ref].name
  resource_group_name = var.resource_groups[each.value.rg].name
  secret_name         = each.key
  secret_value        = each.value.value
}

module "sql_server" {
  depends_on          = [module.resource_group, module.keyvault, module.keyvault_secrets]
  for_each            = var.sql_servers
  source              = "../../azurerm_sql_server"
  sql_name            = each.value.name
  resource_group_name = var.resource_groups[each.value.rg].name
  sqlserver_location  = each.value.location
  sql_serverversion   = each.value.version
  keyvault_name       = var.keyvaults[each.value.keyvault_ref].name
  storage_name        = var.storage_accounts[each.value.storage_account].name
  secret_name         = "sql-admin-user"
  secret_pass         = "sql-admin-pass"

}

module "sql_database" {
  depends_on          = [module.sql_server]
  for_each            = var.sql_databases
  source              = "../../azurerm_sql_database"
  sql_db_name         = each.value.name
  sql_server_name     = var.sql_servers[each.value.sql_server].name
  resource_group_name = var.resource_groups[each.value.rg].name
}

module "public_ip" {
  depends_on = [module.resource_group]
  for_each   = var.public_ips
  source     = "../../azurerm_public_ip"

  publicip_name       = each.value.name
  resource_group_name = var.resource_groups[each.value.rg].name
  location            = each.value.location
  allocation_method   = each.value.allocation_method

}

module "nsg" {
  depends_on                            = [module.resource_group, module.subnet]
  for_each                              = var.nsgs
  source                                = "../../azurerm_nsg"
  nsg_name                              = each.value.name
  resource_group_name                   = var.resource_groups[each.value.rg].name
  location                              = each.value.location
  todo_vnet                             = var.vnets[each.value.vnet].name
  todo_subnet                           = var.subnets[each.value.subnet].name
  #  nic_name                             = module.vm[each.value.vm_ref].nic_name
  security_rule_name                    = each.value.security_rule_name
  security_rule_priority                = each.value.priority
  security_rule_direction               = each.value.direction
  security_rule_access                  = each.value.access
  security_rule_protocol                = each.value.protocol
  security_rule_source_port_range       = each.value.source_port_range
  security_rule_source_port_prefix      = each.value.source_port_prefix
  security_rule_destination_port_prefix = each.value.destination_port_prefix
  security_rule_destination_port_ranges = each.value.destination_port_ranges
  
}

module "vm" {
  depends_on = [module.public_ip, module.vnet, module.subnet, module.public_ip, module.keyvault, module.keyvault_secrets]
  for_each   = var.vms
  source     = "../../azurerm_virtual_machine"

  name                = each.value.name
  vm_size             = each.value.size
  resource_group_name = var.resource_groups[each.value.rg].name
  location            = each.value.location
  secret_user         = "vm-admin-user"
  secret_pass         = "vm-admin-pass"
  subnet_name         = var.subnets[each.value.subnet].name
  vnet                = var.vnets[each.value.vnet].name
  public_ip_name      = var.public_ips[each.value.public_ip_name].name
  nsg_name            = var.nsgs[each.value.nsg_ref].name
  image_publisher     = each.value.image_publisher
  image_offer         = each.value.image_offer
  image_sku           = each.value.image_sku
  image_version       = each.value.image_version
  nic_name            = "${each.value.name}-nic"
  keyvault_name       = each.value.keyvault_name







  
} 