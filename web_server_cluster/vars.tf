variable "location" {
  default = "southcentralus" #Update this variable to specify the region you are deploying to
}

variable "rg01Name" {
	default = "webclusterRG" #Update this to your resource group name
}

variable "vNet01Name" {
	default = "webclusterVNet"
}

variable "vNet01addrSpace" {
	default = "172.16.0.0/16" #This MUST be changed to an appropriate network in CIDR format i.e. 10.0.0.0/16
}

variable "subnet01Name" {
	default = "webclusterSubnet"
}

variable "subn01addrSpace" {
	default = "172.16.100.0/24" #This MUST be changed to an appropriate subnet in CIDR format i.e. 10.0.10.0/24
}

variable "pubName01" {
	default = "webclusterPIP"
}

variable "pubType" {
	default = "static" # This can only be set to 'static' or 'dynamic'
}

variable "avSetName01" {
	default = "webclusterAvSet"
}

variable "nsgName" { 
	default = "webclusterNSG" 
}

variable "rule_name" { 
	default = [ "web", "ssl", "rdc" ] 
}

variable "ports" { 
	default = [ "80", "443", "3389" ] 
}

variable "lbName01" {
	default = "webclusterLB"
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

variable "stgactName01" {
	default = "webclusterstor965452"
}

variable "stgactType01" {
	default = "Standard_LRS"
}

variable "vmNamePrefix" {
	default = "web"
}

variable "vmCount" {
	default = 4
}

variable "vmIPallocationType" {
	default = "static"
}

variable "private_ip_addresses" {
	default = [ "172.16.100.101" ,"172.16.100.102", "172.16.100.103", "172.16.100.104" ]
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
	default = "2016-Datacenter"
}

variable "image_version" {
	default = "latest"
}

variable "os_disk_name" {
	default = "osDisk"
}

variable "number_of_VMs" {
	default = 4 # This is the number of VMs you will be applying your extension to.  Should match the output of ${var.vm_name}
}

variable "extension_Name" {
	default = "iis_Extension"
}

variable "extension_Version" {
	default = "2.20"  # Get the latest version with this command: "Get-AzureVMAvailableExtension -Publisher Microsoft.Powershell"
}

variable "dsc_ps1_url" {
	default = "https://bitbucket.org/davidnite/tf-templates/raw/748822ecc06ffe1a9ed5ec1097e3c115a2d10730/modules/dsc_extension/iis_server.ps1.zip"
}

variable "dsc_ps1_script" {
	default = "iis_server.ps1"
}

variable "dsc_ps1_Function" {
	default = "Main"
}	