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

resource "azure_container_group" "tfcg_test" {
  name = "weatherapi"
  location = azurerm_resource_group.existing_rg.location
  resource_group_name = azurerm_resource_group.existing_rg.name

  ip_address_type = public
  dns_name_label = "ahmedavidwa"
  os_type = "Linux"

  container {
    name = "weatherapi"
    image = "ahmedavid/webapi"
    cpu = "1"
    memory = "1"

    ports {
      port = 80
      protocol = "TCP"
    }
  }
}

# resource "azurerm_resource_group" "tf_test" {
#   name = "ODL-azure-878220"
#   location = "East US"
# }

# resource "azurerm_resource_group" "tf_test" {
#   name     = data.azurerm_resource_group.existing_rg.name
#   location = data.azurerm_resource_group.existing_rg.location
#   lifecycle {
#     prevent_destroy = true
#   }
# }