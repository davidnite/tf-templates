variable "location" {}

variable "name" {}

variable "resource_group_name" {}

variable "public_ip_address_id" {}

variable "frontEndName" {}

variable "backEndName" {}

variable "probeName" {}

variable "probePort" {}

variable "lbRuleNames" { type = "list" }

variable "frontEndPorts" { type = "list" }

variable "backEndPorts" { type = "list" }

variable "natRuleNames" { type = "list" }

variable "natRuleCount" {}

variable "frontEndPortsNAT" { type = "list" }

variable "backEndPortNAT" {}

resource "azurerm_lb" "lb" {
    name = "${var.name}"
    location = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    frontend_ip_configuration {
      name = "${var.frontEndName}"
      public_ip_address_id = "${var.public_ip_address_id}"
    }
}

resource "azurerm_lb_backend_address_pool" "backendpool" {
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id = "${azurerm_lb.lb.id}"
  name = "${var.backEndName}"
}

resource "azurerm_lb_probe" "prb" {
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id = "${azurerm_lb.lb.id}"
  name = "${var.probeName}"
  port = "${var.probePort}"
}

resource "azurerm_lb_rule" "lbRule" {
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id = "${azurerm_lb.lb.id}"
  count = "${length(var.lbRuleNames)}"
  name = "${element(var.lbRuleNames, count.index)}"
  protocol = "Tcp"
  frontend_port = "${element(var.frontEndPorts, count.index)}"
  backend_port = "${element(var.backEndPorts, count.index)}"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.backendpool.id}"
  probe_id = "${azurerm_lb_probe.prb.id}"
  frontend_ip_configuration_name = "${var.frontEndName}"
}

resource "azurerm_lb_nat_rule" "natRule" {
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id = "${azurerm_lb.lb.id}"
  count = "${var.natRuleCount}"
  name = "${element(var.natRuleNames, count.index)}"
  protocol = "Tcp"
  frontend_port = "${element(var.frontEndPortsNAT, count.index)}"
  backend_port = "${var.backEndPortNAT}"
  frontend_ip_configuration_name = "${var.frontEndName}"
}

output "lbBackEndid" {
  value = [ "${azurerm_lb_backend_address_pool.backendpool.id}" ]
}

output "natRuleids" {
	value = [ "${azurerm_lb_nat_rule.natRule.*.id}" ]
}
