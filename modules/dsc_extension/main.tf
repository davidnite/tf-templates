variable "count" {}

variable "extension_Name" {}

variable "location" {}

variable "resource_group_name" {}

variable "vm_name" { type = "list" }

variable "type_handler_version" {}

variable "module_url" {}

variable "dsc_Script" {}

variable "dsc_Function" {}

resource "azurerm_virtual_machine_extension" "dsc" {
    count = "${var.count}"
    name = "${var.extension_Name}"
    location = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    virtual_machine_name = "${element(var.vm_name, count.index)}"
    publisher = "Microsoft.Powershell"
    type = "DSC"
    type_handler_version = "${var.type_handler_version}"

    settings = <<SETTINGS
    {
        "configuration": {
            "url": "${var.module_url}",
            "script": "${var.dsc_Script}",
            "function": "${var.dsc_Function}"
          },
          "configurationArguments": {
            "nodeName": "${element(var.vm_name, count.index)}"
          }
    }
SETTINGS
}