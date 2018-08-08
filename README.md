# David's Templates for Terraform Deployment #

The templates and modules in this repository will give you some predefined code to use for deploying Azure environments with Terraform.

### How do I get set up? ###

* Configure your Azure subscription to use terraform (https://www.terraform.io/docs/providers/azurerm/)
* Run 'apply' against the tfState template
* Run the 'tf_remote_config.ps1' powershell script.  This will configure your terraform scripts to store their state in the storage account created by the tfState template
* Now you can run various different terraform templates.  This repo contains individual templates for deploying simple azure resources, and a template that will deploy a web server cluster.