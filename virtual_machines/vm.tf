data "terraform_remote_state" "infrastructure" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "infrastructure.terraform.tfstate"
  }
}

data "terraform_remote_state" "storage" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "storage.terraform.tfstate"
  }
}

data "terraform_remote_state" "avail_set" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "avail_set.terraform.tfstate"
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

data "terraform_remote_state" "load_balancer" {
  backend = "azure"

  config {
    resource_group_name  = "tfState"
    storage_account_name = "tfstatesa963852"
    container_name       = "tfstate"
    key                  = "load_balancer.terraform.tfstate"
  }
}



module "vms_01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//virtual_machines"
  name = "${var.vmNamePrefix}"
  count = "${var.vmCount}"
  vm_name = "${var.vmNamePrefix}"
  location = "${data.terraform_remote_state.infrastructure.rg01Location}"
  resource_group_name = "${data.terraform_remote_state.infrastructure.rg01Name}"
  availability_set_id = "${data.terraform_remote_state.avail_set.avSet01id}"
  subnet_ids = "${data.terraform_remote_state.infrastructure.subnetIds}"
  lb_backEndPool = "${data.terraform_remote_state.load_balancer.lbBackEndid01}"
  lb_NATrules = "${data.terraform_remote_state.load_balancer.natRuleids01}"
  storage_account_name = "${data.terraform_remote_state.storage.storageName01}"
  storage_primary_blob_endpoint = "${data.terraform_remote_state.storage.primary_blob_endpoint01}"
  private_ip_address_allocation = "${var.vmIPallocationType}"
  private_ip_addresses = "${var.private_ip_addresses}"
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  vm_size = "${var.vm_size}"
  image_publisher = "${var.image_publisher}"
  image_offer = "${var.image_offer}"
  image_sku = "${var.image_sku}"
  image_version = "${var.image_version}"
  os_disk_name = "${var.os_disk_name}"
#  public_ip_addresses = "${module.lan_public_ips.ip_addresses}"
#  public_ip_address_ids = "${module.lan_public_ips.ids}"
#  network_security_group_id = "${module.lan_network_security_group_default.id}"
}