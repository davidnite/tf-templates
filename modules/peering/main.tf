variable vnet1_name {
  description = "Name of the source virtual network"
}

variable vnet2_name {
  description = "Name of the destination virtual network"
}

variable vnet2_id {
  description = "Id of the destination virtual network"
}

variable resource_group_name {
  description = "Name of the source resource group"
}

resource "azurerm_virtual_network_peering" "peer" {
  name                      = "peer-${var.vnet1_name}-to-${var.vnet2_name}"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${var.vnet1_name}"
  remote_virtual_network_id = "${var.vnet2_id}"
}

output "name" {
  value = "${azurerm_virtual_network_peering.peer.name}"
}