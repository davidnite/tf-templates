output "lbBackEndid01" {
  value = [ "${module.load_balancer01.lbBackEndid}" ]
}

output "natRuleids01" {
	value = [ "${module.load_balancer01.natRuleids}" ]
}