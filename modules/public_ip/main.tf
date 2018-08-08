variable name {}

variable resource_group_name {}

variable location {}

variable public_ip_address_allocation {}

resource "azurerm_public_ip" "pi" {
  location = "${var.location}"
  name  = "${var.name}"
  resource_group_name = "${var.resource_group_name}"
  public_ip_address_allocation = "${var.public_ip_address_allocation}"
}

output "pipId" {
  value = "${azurerm_public_ip.pi.id}"
}

output "ip_address" {
  value = "${azurerm_public_ip.pi.ip_address}"
}
