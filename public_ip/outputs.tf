output "pubId01" {
  value = "${module.public_ip01.pipId}"
}

output "pubIp01" {
  value = ["${module.public_ip01.ip_address}"]
}
