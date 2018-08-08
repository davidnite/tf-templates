variable "number_of_VMs" {
	default = 2 # This is the number of VMs you will be applying your extension to.  Should match the output of ${var.vm_name}
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