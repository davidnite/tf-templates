variable "name" {}

variable "location" {} 

variable "count" {}

variable "count_offset" { default = 100 } 

variable "subnet_ids" { type = "list" }

variable "private_ip_address_allocation" {}

variable "private_ip_addresses" { type = "list" }

# variable "public_ip_addresses" { type = "list" }

# variable "public_ip_address_ids" { type = "list" }

variable "resource_group_name" {}

# variable "network_security_group_id" {}

variable "availability_set_id" {}

variable "vm_name" {}

variable "vm_size" {}

variable "storage_account_name" {}

variable "storage_primary_blob_endpoint" {}

variable "image_publisher" {}

variable "image_offer" {}

variable "image_sku" {}

variable "admin_username" {}

variable "admin_password" {}

variable "os_disk_name" {}

variable "lb_backEndPool" { type = "list" }

variable "lb_NATrules" { type = "list" }


resource "azurerm_network_interface" "ni" {
    count = "${var.count}"
    name = "${var.vm_name}NI${format("%02d", var.count_offset + count.index + 1)}"
    location = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    # network_security_group_id = "${var.network_security_group_id}"
    ip_configuration {
        name = "ipconfig"
        subnet_id = "${element(var.subnet_ids, count.index)}"
        private_ip_address_allocation = "${var.private_ip_address_allocation}"
        private_ip_address = "${element(var.private_ip_addresses, count.index)}"
        load_balancer_backend_address_pools_ids = [ "${var.lb_backEndPool}" ]
      #  load_balancer_inbound_nat_rules_ids = [ "${element(var.lb_NATrules, count.index)}" ] - Not ready yet
    }
}

resource "azurerm_storage_container" "osdisk" {
    name = "vhds"
    storage_account_name = "${var.storage_account_name}"
    resource_group_name = "${var.resource_group_name}"
    container_access_type = "private"
}

resource "azurerm_virtual_machine" "vm" {
    count = "${var.count}"
    name = "${var.vm_name}${format("%02d", var.count_offset + count.index + 1)}"
    location = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
	  availability_set_id = "${var.availability_set_id}"
    network_interface_ids = ["${element(azurerm_network_interface.ni.*.id, count.index)}"]
    vm_size = "${var.vm_size}"

    /*
    plan {
        name = "${var.image_sku}"
        publisher = "${var.image_publisher}"
        product = "${var.image_offer}"
    }
    */

    storage_image_reference {
        publisher = "${var.image_publisher}"
        offer = "${var.image_offer}"
        sku = "${var.image_sku}"
    }

    storage_os_disk {
        name = "${var.vm_name}${format("%02d", var.count_offset + count.index + 1)}-${var.os_disk_name}"
        vhd_uri = "${var.storage_primary_blob_endpoint}${azurerm_storage_container.osdisk.name}/${var.vm_name}${format("%02d", var.count_offset + count.index + 1)}-${var.os_disk_name}.vhd"
        caching = "ReadWrite"
        create_option = "FromImage"
    }

    os_profile {
        computer_name = "${var.vm_name}${format("%02d", var.count_offset + count.index + 1)}"
        admin_username = "${var.admin_username}"
        admin_password = "${var.admin_password}"
    }
}

output "vm_ids" {
  value = [ "${azurerm_virtual_machine.vm.*.id}" ]
}

output "vm_names" {
    value = [ "${azurerm_virtual_machine.vm.*.name}" ]
}