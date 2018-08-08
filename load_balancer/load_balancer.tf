data "terraform_remote_state" "infrastructure" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "infrastructure.terraform.tfstate"
  }
}

data "terraform_remote_state" "public_ip" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "public_ip.terraform.tfstate"
  }
}

module "load_balancer01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//load_balancer"
  location = "${data.terraform_remote_state.infrastructure.rg01Location}"
  name = "${var.lbName01}"
  resource_group_name = "${data.terraform_remote_state.infrastructure.rg01Name}"
  public_ip_address_id = "${data.terraform_remote_state.public_ip.pubId01}"
  frontEndName = "${var.frontEndName01}"
  backEndName = "${var.backEndName01}"
  probeName = "${var.probeName01}"
  probePort = "${var.probePort01}"
  lbRuleNames = "${var.lbRuleNames01}"
  frontEndPorts = "${var.frontEndPorts01}"
  backEndPorts = "${var.backEndPorts01}"
  natRuleNames = "${var.natRuleNames01}"
  natRuleCount = "${var.natRuleCount01}"
  frontEndPortsNAT = "${var.frontEndPortsNAT01}"
  backEndPortNAT = "${var.backEndPortNAT01}"
}

# Uncomment the module below to add a second load balancer.  It should probably have a separate resource group and public IP...

/*

module "load_balancer02" {
  source = "bitbucket.org/davidnite/tf-templates//modules//load_balancer"
  location = "${data.terraform_remote_state.infrastructure.rg01Location}"
  name = "${var.lbName02}"
  resource_group_name = "${data.terraform_remote_state.infrastructure.rg01Name}"
  public_ip_address_id = "${data.terraform_remote_state.public_ip.pubId01}"
  frontEndName = "${var.frontEndName02}"
  backEndName = "${var.backEndName02}"
  probeName = "${var.probeName02}"
  probePort = "${var.probePort02}"
  lbRuleNames = "${var.lbRuleNames02}"
  frontEndPorts = "${var.frontEndPorts02}"
  backEndPorts = "${var.backEndPorts02}"
  natRuleNames = "${var.natRuleNames02}"
  natRuleCount = "${var.natRuleCount02}"
  frontEndPortsNAT = "${var.frontEndPortsNAT02}"
  backEndPortsNAT = "${var.backEndPortsNAT02}"
}

*/