variable "lbName01" {
	default = "my_load_balancer01"
}

variable "frontEndName01" {
	default = "lb_FrontEnd_pool"
}

variable "backEndName01" {
	default = "lb_BackEnd_pool"
}

variable "probeName01" {
	default = "lb_Probe"
}

variable "probePort01" {
	default = 80
}

variable "lbRuleNames01" {
	default = [ "Http-web", "Https-ssl" ]
}

variable "frontEndPorts01" {
	default = [ "80", "443" ]
}

variable "backEndPorts01" {
	default = [ "80", "443" ]
}

variable "natRuleNames01" {
	default = [ "Srv01-RDP", "Srv02-RDP" ]
}

variable "natRuleCount01" {
	default = 2
}

variable "frontEndPortsNAT01" {
	default = [ "3387", "3388" ]
}

variable "backEndPortNAT01" {
	default = 3389
}

# Uncomment the variables below to add a second load balancer

/*

variable "lbName02" {
	default = "my_load_balancer02"
}

variable "frontEndName02" {
	default = "lb_FrontEnd_pool"
}

variable "backEndName02" {
	default = "lb_BackEnd_pool"
}

variable "probeName02" {
	default = "lb_Probe"
}

variable "probePort02" {
	default = 80
}

variable "lbRuleNames02" {
	default = [ "Http-web", "Https-ssl" ]
}

variable "frontEndPorts02" {
	default = [ "80", "443" ]
}

variable "backEndPorts02" {
	default = [ "80", "443" ]
}

variable "natRuleNames02" {
	default = [ "Srv01-RDP", "Srv02-RDP" ]
}

variable "natRuleCount02" {
	default = 2
}

variable "frontEndPortsNAT02" {
	default = [ "3387", "3388" ]
}

variable "backEndPortNAT02" {
	default = 3389
}

*/