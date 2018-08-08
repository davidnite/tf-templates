data "terraform_remote_state" "infrastructure" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "infrastructure.terraform.tfstate"
  }
}

data "terraform_remote_state" "virtual_machines" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "virtual_machines.terraform.tfstate"
  }
}

module "dsc_extension" {
	source = "bitbucket.org/davidnite/tf-templates//modules//dsc_extension"
	count = "${var.number_of_VMs}" 
	name = "${var.extension_Name}"
	location = "${data.terraform_remote_state.infrastructure.rg01Location}"
	resource_group_name = "${data.terraform_remote_state.infrastructure.rg01Name}"
	vm_name = "${data.terraform_remote_state.virtual_machines.vm_01_names}"
	type_handler_version = "${var.extension_Version}"
	module_url = "${var.dsc_ps1_url}"
	dsc_Script = "${var.dsc_ps1_script}"
	dsc_Function = "${var.dsc_ps1_Function}"
}
