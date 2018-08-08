output "primary_blob_endpoint01" {
    value = "${module.storage_account01.primary_blob_endpoint}"
}

output "storageName01" {
    value = "${module.storage_account01.name}"
}