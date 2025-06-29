variable "resource_groups" { type = map(any) }
variable "vnets" { type = map(any) }
variable "subnets" { type = map(any) }
variable "storage_accounts" { type = map(any) }
variable "keyvaults" { type = map(any) }
variable "sql_servers" { type = map(any) }
variable "vms" { type = map(any) }
variable "public_ips" { type = map(any) }
# variable "secrets" {
#   type = map(any)
# }
variable "keyvault_secrets" { type = map(any) }
variable "sql_databases" { type = map(any) }
variable "nsgs" { type = map(any) }


# variable "nic_name" {}