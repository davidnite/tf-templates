variable "vmNamePrefix" {
	default = "my-VM-"
}

variable "vmCount" {
	default = 2
}

variable "vmIPallocationType" {
	default = "static"
}

variable "private_ip_addresses" {
	default = [ "10.0.10.101" ,"10.0.10.102" ]
}

variable "admin_username" {
	default = "admin_user"
}

variable "admin_password" {
	default = "Trustno1!"
}

variable "vm_size" {
	default = "Standard_D2_v2"
}

variable "image_publisher" {
	default = "MicrosoftWindowsServer"
}

variable "image_offer" {
	default = "WindowsServer"
}

variable "image_sku" {
	default = "2012-R2-Datacenter"
}

variable "image_version" {
	default = "latest"
}

variable "os_disk_name" {
	default = "osDisk"
}	