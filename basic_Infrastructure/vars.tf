variable "location" {
  default = "southcentralus" #Update this variable to specify the region you are deploying to
}

variable "rg01Name" {
	default = "my_resource_group_name01" #Update this to your resource group name
}

# Uncomment the below variables to deploy multiple resource groups with different names

/*

variable "rg02Name" {
	default = "my_resource_group_name02"
}

*/

variable "vNet01Name" {
	default = "my_vNet_name01"
}

# Uncomment the below variables to deploy multiple virtual networks with different names

/*

variable "vNet02Name" {
	default = "my_vNet_name02"
}

*/

variable "vNet01addrSpace" {
	default = "10.0.0.0/16" #This MUST be changed to an appropriate network in CIDR format i.e. 10.0.0.0/16
}

# Uncomment the below variables if you exposed the multiple vNet names above.  Each address space must be unique and not overlapping!

/*

variable "vNet02addrSpace" {
	default = "vNet02_address_space"
}

*/

variable "subnet01Name" {
	default = "my_subnet_name01"
}

# Uncomment the below variables to deploy subnets to your subsequent virtual networks

/*

variable "subnet02Name" {
	default = "my_subnet_name02"
}

*/

variable "subn01addrSpace" {
	default = "10.0.10.0/24" #This MUST be changed to an appropriate subnet in CIDR format i.e. 10.0.10.0/24
}

# Uncomment the below variables if you are deploying multiple subnets.

/*

variable "subn02addrSpace" {
	default = "subnet02_address_space" #This MUST be changed to an appropriate subnet in CIDR format i.e. 10.0.10.0/24
}

*/
