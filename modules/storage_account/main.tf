variable resource_group_name {
  description = "Resource group name"
}

variable location {
   description = "Geographic location"
}

variable account_name {
  description = "Storage account name. Must be unique across Azure." 
}

variable account_tier {
  default = "Standard"
  description = "Storage acount type (i.e. Standard, Premium)"
}

variable "account_replication_type" {
  default = "LRS"
  description = "Storage account replication type (i.e. LRS, GRS, RAGRS, ZRS)"
}

resource "azurerm_storage_account" "sa" {
    name = "${var.account_name}"
    resource_group_name = "${var.resource_group_name}"
    location = "${var.location}"
    account_tier = "${var.account_tier}"
    account_replication_type = "${var.account_replication_type}"
}

output "primary_blob_endpoint" {
    value = "${azurerm_storage_account.sa.primary_blob_endpoint}"
}

output "name" {
    value = "${azurerm_storage_account.sa.name}"
}

output "primary_access_key" {
  value = "${azurerm_storage_account.sa.primary_access_key}"
}
