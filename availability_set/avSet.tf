data "terraform_remote_state" "infrastructure" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "infrastructure.terraform.tfstate"
  }
}

module "avail_set_01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//avail_set"
  name = "${var.avSetName01}"
  location = "${data.terraform_remote_state.infrastructure.rg01Location}"
  resource_group_name = "${data.terraform_remote_state.infrastructure.rg01Name}"
}

# Uncomment the module below to add multiple availability sets

/*

module "avail_set_02" {
  source = "bitbucket.org/davidnite/terraform//templates//Modules//avail_set"
  name = "${var.avSetName02}"
  location = "${var.location}"
  resource_group_name = "${data.terraform_remote_state.infrastructure.azurerm_resource_group.resource_group_01.name}"
}

*/