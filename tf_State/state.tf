module "terraform_state_resourceGroup" {
  source = "github.com/davidnite/tf-templates//modules//resource_group"
  name = "tfState"
  location = "southcentralus"
}

module "terraform_state_storageAccount" {
  source = "github.com/davidnite/tf-templates//modules//storage_account"
  location = "southcentralus"
  account_name = "tfstatesa963852"
  account_tier = "Standard"
  account_replication_type = "LRS"
  resource_group_name = "${module.terraform_state_resourceGroup.name}"
}

resource "azurerm_storage_container" "tfState" {
  name                  = "tfstate"
  resource_group_name   = "${module.terraform_state_resourceGroup.name}"
  storage_account_name  = "${module.terraform_state_storageAccount.name}"
  container_access_type = "private"
}
/*
output "primary_access_key" {
  value = "${azurerm_storage_account.terraform_state_storageAccount.primary_access_key}"
}
*/