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

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_config.nsg_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  dynamic "security_rule" {
    for_each = var.nsg_config.nsg_rules
    content {
      name                       = security_rule.value["name"]      
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]    
      access                     = security_rule.value["access"]    
      protocol                   = security_rule.value["protocol"]    
      source_port_range          = security_rule.value["source_port_range"]    
      destination_port_range     = security_rule.value["destination_port_range"]    
      source_address_prefix      = security_rule.value["source_address_prefix"]    
      destination_address_prefix = security_rule.value["destination_address_prefix"]    
    }
  }

  tags = data.azurerm_resource_group.rg.tags
}
