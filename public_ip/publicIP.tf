data "terraform_remote_state" "infrastructure" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "infrastructure.terraform.tfstate"
  }
}

module "public_ip01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//public_ip"
  name = "${var.pubName01}"
  location = "${data.terraform_remote_state.infrastructure.rg01Location}"
  resource_group_name = "${data.terraform_remote_state.infrastructure.rg01Name}"
  public_ip_address_allocation = "${var.pubType}"
}

# Uncomment the variable below to add multiple public IP addresses

/*

module "public_ip02" {
  source = "bitbucket.org/davidnite/tf-templates//modules//public_ip"
  name = "${var.pubName02}"
  location = "${var.location}"
  resource_group_name = "${data.terraform_remote_state.infrastructure.rg01Name}"
  public_ip_address_allocation = "${var.pubType}"
}

*/
