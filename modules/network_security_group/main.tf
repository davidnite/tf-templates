variable "name" {}

variable "location" {}

variable "resource_group_name" {}

variable "rule_count_offset" { 
   default = 100 
} 

variable "vm_count_offset" {
  default = 0
}

variable "rule_name" {
  type = "list" 
}

variable "ports" {
  type = "list" 
}

resource "azurerm_network_security_group" "nsg" {
  name = "${var.name}${format("%02d", var.vm_count_offset + 1)}"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_network_security_rule" "sr" {
  count = "${length(var.rule_name)}"  
  name = "${element(var.rule_name, count.index)}"
  priority = "${format("%03d", var.rule_count_offset + count.index + 1)}"
  direction = "Inbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "${element(var.ports, count.index)}"
  source_address_prefix = "*"
  destination_address_prefix = "*"
  resource_group_name = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

output "id" {
  value = "${azurerm_network_security_group.nsg.id}"
}