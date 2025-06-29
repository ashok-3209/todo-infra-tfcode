variable "nsg_name" {
    type = string
}
variable "location" {
    type = string
}
variable "resource_group_name" {
    type = string
}
variable "todo_subnet"{
    type = string
}
variable "todo_vnet"{
    type = string
}

variable "security_rule_name" {
    type = string
}
variable "security_rule_priority" {
    type = string
}
variable "security_rule_direction" {
    type = string
}
variable "security_rule_access" {
    type = string
}
variable "security_rule_protocol" {
    type = string
}
variable "security_rule_source_port_range" {
    type = string
}
variable "security_rule_destination_port_ranges" {
    type = list(string)
}
variable "security_rule_source_port_prefix" {
    type = string
}
variable "security_rule_destination_port_prefix" {
    type = string
}

# variable "nic_name" {
#      type = string
  
# }
