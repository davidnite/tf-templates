module "resource_group_01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//resource_group"
  name = "${var.rg01Name}"
  location = "${var.location}"
}

# Uncomment this code to deploy multiple resource groups with different names

/*

module "resource_group_02" {
  source = "bitbucket.org/davidnite/tf-templates//modules//resource_group"
  name = "${var.rg02Name}"
  location = "${var.location}"
}

*/

module "virtual_network_01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//virtual_network"
  name = "${var.vNet01Name}"
  location = "${var.location}"
  resource_group_name = "${module.resource_group_01.name}"
  address_space = "${var.vNet01addrSpace}"
}

# Uncomment this code to deploy multiple networks with different names.  Be aware of which resource group it deploys to

/*

module "virtual_network_02" {
  source = "bitbucket.org/davidnite/tf-templates//modules//virtual_network"
  name = "${var.vNet02Name}"
  location = "${var.location}"
  resource_group_name = "${module.resource_group_02.name}"
  address_space = "${var.vNet02addrSpace}"
}

*/

module "subnet_01" {
  source = "bitbucket.org/davidnite/tf-templates//modules//subnet"
  name = "${var.subnet01Name}"
  resource_group_name = "${module.resource_group_01.name}"
  virtual_network_name = "${module.virtual_network_01.name}"
  address_prefixes = ["${var.subn01addrSpace}"]
}

# Uncomment this code to deploy a subnet to your subsequent vNets

/*

module "subnet_02" {
  source = "bitbucket.org/davidnite/tf-templates//modules//subnet"
  name = "${var.subnet02Name}"
  resource_group_name = "${module.resource_group_02.name}"
  virtual_network_name = "${module.virtual_network_02.name}"
  address_prefixes = ["${var.subn02addrSpace}"]
}

*/

# If you are deploying more than one virtual network and want to peer them, use the modules below

/*

module "vnet01_peering" {
  source = "bitbucket.org/davidnite/tf-templates//modules//peering"
  vnet1_name = "${module.virtual_network_01.name}"
  vnet2_name = "${module.virtual_network_02.name}"
  vnet2_id = "${module.virtual_network_02.id}"
  resource_group_name = "${module.resource_group_01.name}"
}

module "vnet02_peering" {
  source = "bitbucket.org/davidnite/tf-templates//modules//peering"
  vnet1_name = "${module.virtual_network_02.name}"
  vnet2_name = "${module.virtual_network_01.name}"
  vnet2_id = "${module.virtual_network_01.id}"
  resource_group_name = "${module.resource_group_01.name}"
}

*/