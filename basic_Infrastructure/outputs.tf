output "rg01Name" {
  value = "${module.resource_group_01.name}"
}

output "rg01Id" {
  value = "${module.resource_group_01.id}"
}

output "rg01Location" {
	value = "${module.resource_group_01.location}"
}

output "subnetIds" {
  value = [ "${module.subnet_01.ids}" ]
}