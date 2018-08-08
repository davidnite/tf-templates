variable "pubName01" {
	default = "public_IP_01"
}

variable "location" {
	default = "southcentralus"
}

variable "pubType" {
	default = "static" # This can only be set to 'static' or 'dynamic'
}

# Uncomment the variable(s) below if you want to add multiple public IPs

/*

variable "pubName02" {
	default = "public_IP_02"
}

*/