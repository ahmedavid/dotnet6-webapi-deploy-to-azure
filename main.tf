terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.46.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

data "azurerm_resource_group" "existing_rg" {
  name = "ODL-azure-878220"
}

# resource "azurerm_resource_group" "tf_test" {
#   name = "ODL-azure-878220"
#   location = "East US"
# }

resource "azurerm_resource_group" "tf_test" {
  name     = data.azurerm_resource_group.existing_rg.name
  location = data.azurerm_resource_group.existing_rg.location
}