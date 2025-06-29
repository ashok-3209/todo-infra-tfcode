resource_groups = {
  rg1 = {
    name     = "AZTODO-NP-RG",
    location = "West US"
  }

########Added new RG into TODO Infra######
  rg1 = {
    name     = "AZTODO-Dev-RG",
    location = "East US"
  }
}

vnets = {
  vnet1 = { name = "aznptodo-vnet", rg = "rg1", location = "West US", address_space = ["10.0.0.0/16"] }
  vnet2 = { name = "azdevtodo-vnet", rg = "rg2", location = "East US", address_space = ["10.0.1.0/16"] }
}

subnets = {
  frontend = { name = "frontendnp-subnet", vnet = "vnet1", rg = "rg1", address_prefixes = ["10.0.1.0/24"] }
  backend  = { name = "backendnp-subnet", vnet = "vnet1", rg = "rg1", address_prefixes = ["10.0.2.0/24"] }
}

storage_accounts = {
  sa1 = { name = "todostorage002", rg = "rg1", location = "West US" }
}

keyvaults = {
  kv1 = { name = "aztodonpkv00111", rg = "rg1", location = "West US" }
}

keyvault_secrets = {
  sql-admin-user = {
    value        = "sqladmin"
    rg           = "rg1"
    keyvault_ref = "kv1"
  }
  sql-admin-pass = {
    value        = "StrongP@ssw0rd!"
    rg           = "rg1"
    keyvault_ref = "kv1"
  }
  vm-admin-user = {
    value        = "devopsadmin"
    rg           = "rg1"
    keyvault_ref = "kv1"
  }
  vm-admin-pass = {
    value        = "P@ssword@456"
    rg           = "rg1"
    keyvault_ref = "kv1"
  }
}

sql_servers = {
  sql1 = {
    name            = "aznptdosql002"
    rg              = "rg1"
    location        = "West US"
    version         = "12.0"
    keyvault_ref    = "kv1"
    storage_account = "sa1"
  }
}

sql_databases = {
  tododb = {
    name       = "aznptododb002"
    sql_server = "sql1"
    rg         = "rg1"
  }
}




public_ips = {
  frontend-pip = { name = "frontend-pip", rg = "rg1", location = "West US", allocation_method = "Static" }
  backend-pip  = { name = "backend-pip", rg = "rg1", location = "West US", allocation_method = "Static" }
}

vms = {
  frontend = {
    name            = "frontend-vm01"
    rg              = "rg1"
    location        = "West US"
    size            = "Standard_B2s"
    subnet          = "frontend"
    vnet            = "vnet1"
    public_ip_name  = "frontend-pip"
    nsg_ref         = "frontend-nsg"
    image_offer     = "UbuntuServer"
    image_publisher = "Canonical"
    image_sku       = "18.04-LTS"
    image_version   = "latest"
    keyvault_name   = "aztodonpkv00111"
  }
  backend = {
    name            = "backend-vm01"
    rg              = "rg1"
    location        = "West US"
    size            = "Standard_B2s"
    subnet          = "backend"
    vnet            = "vnet1"
    public_ip_name  = "backend-pip"
    nsg_ref         = "backend-nsg"
    image_offer     = "UbuntuServer"
    image_publisher = "Canonical"
    image_sku       = "18.04-LTS"
    image_version   = "latest"
    keyvault_name   = "aztodonpkv00111"
  }
}

# nsgs = {
#   frontend-nsg = {
#     name                    = "frontend-nsg"
#     rg                      = "rg1"
#     location                = "West US"
#     vnet                    = "vnet1"
#     subnet                  = "frontend"
#     vm_ref                  = "frontend"  ## Isse hi module.vm["frontend"] call hoga
#     security_rule_name      = "allow-80"
#     priority                = 100
#     direction               = "Inbound"
#     access                  = "Allow"
#     protocol                = "Tcp"
#     source_port_range       = "*"
#     source_port_prefix      = "*"
#     destination_port_prefix = "80"
#     destination_port_ranges = ["22", "80"]
#   }
#   backend-nsg = {
#     name                    = "backend-nsg"
#     rg                      = "rg1"
#     location                = "West US"
#     vnet                    = "vnet1"
#     subnet                  = "backend"
#     vm_ref                  = "backend"
#     security_rule_name      = "allow-80"
#     priority                = 101
#     direction               = "Inbound"
#     access                  = "Allow"
#     protocol                = "Tcp"
#     source_port_range       = "*"
#     source_port_prefix      = "*"
#     destination_port_prefix = "80"
#     destination_port_ranges = ["80", "8000", "22"]
#   }
# }

# vms = {
#   frontend = {
#     name            = "frontend-vm01"
#     rg              = "rg1"
#     location        = "West US"
#     size            = "Standard_B2s"
#     subnet          = "frontend"
#     nsg_ref         = "frontend-nsg"
#     vnet            = "vnet1"
#     public_ip_name  = "frontend-pip"
#     nsg_ref         = "frontend-nsg"
#     image_offer     = "UbuntuServer"
#     image_publisher = "Canonical"
#     image_sku       = "18.04-LTS"
#     image_version   = "latest"
#     nic_name        = "frontend-nic"
#     keyvault_name   = "aztodonpkv00111"
#   }
#   backend = {
#     name            = "backend-vm01"
#     rg              = "rg1"
#     location        = "West US"
#     size            = "Standard_B2s"
#     subnet          = "backend"
#     vnet            = "vnet1"
#     nsg_ref         = "backend-nsg"
#     public_ip_name  = "backend-pip"
#     nsg_ref         = "backend-nsg"
#     image_offer     = "UbuntuServer"
#     image_publisher = "Canonical"
#     image_sku       = "18.04-LTS"
#     image_version   = "latest"
#     nic_name        = "backend-nic"
#     keyvault_name   = "aztodonpkv0011"
#   }
# }


nsgs = {
  frontend-nsg = {
    name                    = "frontend-nsg"
    rg                      = "rg1"
    vm_ref                  = "frontend-vm-key"  ##
    location                = "West US"
    vnet                    = "vnet1"
    subnet                  = "frontend"
    vm_ref                  = "frontend"
    security_rule_name      = "allow-80"
    priority                = 100
    direction               = "Inbound"
    access                  = "Allow"
    protocol                = "Tcp"
    source_port_range       = "*"
    source_port_prefix      = "*"
    destination_port_prefix = "80"
    destination_port_ranges = ["22", "80"]
  }
  backend-nsg = {
    name                    = "backend-nsg"
    rg                      = "rg1"
    location                = "West US"
    vm_ref                  = "backend-vm-key"
    vnet                    = "vnet1"
    subnet                  = "backend"
      vm_ref                  = "backend"
    security_rule_name      = "allow-80"
    priority                = 101
    direction               = "Inbound"
    access                  = "Allow"
    protocol                = "Tcp"
    source_port_range       = "*"
    source_port_prefix      = "*"
    destination_port_prefix = "80"
    destination_port_ranges = ["80", "8000", "22"]
  }
}
