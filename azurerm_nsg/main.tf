resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = var.security_rule_name
    priority                   = var.security_rule_priority
    direction                  = var.security_rule_direction
    access                     = var.security_rule_access
    protocol                   = var.security_rule_protocol
    source_port_range          = var.security_rule_source_port_range
    source_address_prefix      = var.security_rule_source_port_prefix
    destination_address_prefix = var.security_rule_destination_port_prefix
    destination_port_ranges = var.security_rule_destination_port_ranges
  }
}


data "azurerm_subnet" "subnet_data" {
  name                 = var.todo_subnet
  virtual_network_name = var.todo_vnet
  resource_group_name  = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_assc" {
  subnet_id                 = data.azurerm_subnet.subnet_data.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# data "azurerm_network_interface" "example" {
#   name                = var.nic_name
#   resource_group_name = var.resource_group_name
# }

# resource "azurerm_network_interface_security_group_association" "example" {
#   network_interface_id      = data.azurerm_network_interface.example.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }

