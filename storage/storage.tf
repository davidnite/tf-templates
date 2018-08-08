data "terraform_remote_state" "infrastructure" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "infrastructure.terraform.tfstate"
  }
}

module "storage_account01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//storage_account"
  location = "${data.terraform_remote_state.infrastructure.rg01Location}"
  account_name = "${var.stgactName01}"
  account_type = "${var.stgactType01}"
  resource_group_name = "${data.terraform_remote_state.infrastructure.rg01Name}"
}