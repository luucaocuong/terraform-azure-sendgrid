terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.67.0"
    }
  }
}
  
provider "azurerm" {
  features {}
  skip_provider_registration = true
}
############################################################################

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group_template_deployment" "send_grid" {
  name                = "sendgrid-template"
  resource_group_name = "your-resource-gr"
  deployment_mode     = "Incremental"
  template_content = <<TEMPLATE
{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01-preview/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "resources": [
        {
            "type": "Microsoft.SaaS/resources",
            "apiVersion": "2018-03-01-beta",
            "name": "sendgrid-test-name",
            "location": "global",
            "properties": {
                "saasResourceName": "sendgrid-test-name",
                "publisherId": "sendgrid",
                "SKUId": "free-100",
                "offerId": "tsg-saas-offer",
                "quantity": "1",
                "termId": "hjdtn7tfnxcy",
                "autoRenew": true,
                "paymentChannelType": "SubscriptionDelegated",
                "paymentChannelMetadata": {
                    "AzureSubscriptionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxx"
                },
                "publisherTestEnvironment": "",
                "storeFront": "AzurePortal"
            }
        }
    ]
}
TEMPLATE
}