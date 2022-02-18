provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.   
  features {}
  skip_provider_registration = true
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.78.0"
    }
  }
}

## Declaring Data for the process 

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

## Resources

resource "azurerm_storage_account" "sa" {
  count                    = length(var.sa_config)
  name                     = var.sa_config[count.index].name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = var.sa_config[count.index].account_tier
  account_replication_type = var.sa_config[count.index].account_replication_type

  tags = data.azurerm_resource_group.rg.tags
}
