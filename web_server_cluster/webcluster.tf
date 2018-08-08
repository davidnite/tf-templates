module "resource_group01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//resource_group"
  name = "${var.rg01Name}"
  location = "${var.location}"
}

module "virtual_network_01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//virtual_network"
  name = "${var.vNet01Name}"
  location = "${var.location}"
  resource_group_name = "${module.resource_group01.name}"
  address_space = "${var.vNet01addrSpace}"
}

module "subnet_01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//subnet"
  name = "${var.subnet01Name}"
  resource_group_name = "${module.resource_group01.name}"
  virtual_network_name = "${module.virtual_network_01.name}"
  address_prefixes = ["${var.subn01addrSpace}"]
}

module "public_ip01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//public_ip"
  name = "${var.pubName01}"
  location = "${var.location}"
  resource_group_name = "${module.resource_group01.name}"
  public_ip_address_allocation = "${var.pubType}"
}

module "avail_set_01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//avail_set"
  name = "${var.avSetName01}"
  location = "${var.location}"
  resource_group_name = "${module.resource_group01.name}"
}

module "nsg" {
  source = "bitbucket.org/davidnite/tf-templates//modules//network_security_group"
  name = "${var.nsgName}"
  location = "${var.location}"
  resource_group_name = "${module.resource_group01.name}"
  rule_name = "${var.rule_name}"
  ports = "${var.ports}"
}

module "load_balancer01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//load_balancer"
  location = "${var.location}"
  name = "${var.lbName01}"
  resource_group_name = "${module.resource_group01.name}"
  public_ip_address_id = "${module.public_ip01.pipId}"
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

module "storage_account01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//storage_account"
  location = "${var.location}"
  account_name = "${var.stgactName01}"
  account_type = "${var.stgactType01}"
  resource_group_name = "${module.resource_group01.name}"
}

module "vms_01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//virtual_machines"
  name = "${var.vmNamePrefix}"
  count = "${var.vmCount}"
  vm_name = "${var.vmNamePrefix}"
  location = "${var.location}"
  resource_group_name = "${module.resource_group01.name}"
  availability_set_id = "${module.avail_set_01.id}"
  subnet_ids = "${module.subnet_01.ids}"
  lb_backEndPool = "${module.load_balancer01.lbBackEndid}"
  lb_NATrules = "${module.load_balancer01.natRuleids}"
  storage_account_name = "${module.storage_account01.name}"
  storage_primary_blob_endpoint = "${module.storage_account01.primary_blob_endpoint}"
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

module "dsc_extension" {
	source = "bitbucket.org/davidnite/tf-templates//modules//dsc_extension"
	count = "${var.number_of_VMs}" 
	extension_Name = "${var.extension_Name}"
	location = "${var.location}"
	resource_group_name = "${module.resource_group01.name}"
	vm_name = "${module.vms_01.vm_names}"
	type_handler_version = "${var.extension_Version}"
	module_url = "${var.dsc_ps1_url}"
	dsc_Script = "${var.dsc_ps1_script}"
	dsc_Function = "${var.dsc_ps1_Function}"
}


