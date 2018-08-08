variable "name" {}

variable "location" {} 

variable "resource_group_name" {}

resource "azurerm_availability_set" "as" {
  name                = "${var.name}-avset"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
}

output "id" {
  value = "${azurerm_availability_set.as.id}"
}