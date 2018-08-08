variable "name" {}

variable "location" {} 

resource "azurerm_resource_group" "rg" {
    name     = "${var.name}"
    location = "${var.location}"
}

output "id" {
  value = "${azurerm_resource_group.rg.id}"
}

output "name" {
  value = "${azurerm_resource_group.rg.name}"
}

output "location" {
	value = "${azurerm_resource_group.rg.location}"
}