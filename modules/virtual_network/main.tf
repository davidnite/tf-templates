variable "name" {}

variable "location" {} 

variable "address_space" {}

variable "resource_group_name" {}

resource "azurerm_virtual_network" "vn" {
  name                = "${var.name}"
  resource_group_name = "${var.resource_group_name}"
  address_space       = ["${split(",",var.address_space)}"]
  location            = "${var.location}"
}


output "id" {
  value = "${azurerm_virtual_network.vn.id}"
}

output "name" {
  value = "${azurerm_virtual_network.vn.name}"
}
