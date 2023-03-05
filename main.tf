terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.46.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "storage_rg"
    storage_account_name = "ahmedavid"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}

resource "azurerm_resource_group" "terraform_devops_rg" {
  name = "terraform_devops"
  location = "germanywestcentral"
}
# data "azurerm_resource_group" "terraform_devops_rg" {
#   name = "terraform_devops"
# }

# output "resource_group_location" {
#   value = data.azurerm_resource_group.terraform_devops_rg.location
# }
resource "azurerm_container_group" "tfcg_test" {
  name = "weatherapi"
  location = data.azurerm_resource_group.terraform_devops_rg.location
  resource_group_name = data.azurerm_resource_group.terraform_devops_rg.name

  ip_address_type = "Public"
  dns_name_label = "ahmedavidwa"
  os_type = "Linux"

  container {
    name = "weatherapi"
    image = "ahmedavid/webapi:${var.imagebuild}"
    cpu = "1"
    memory = "1"

    ports {
      port = 80
      protocol = "TCP"
    }
  }
}

# # resource "azurerm_resource_group" "tf_test" {
# #   name = "ODL-azure-878220"
# #   location = "East US"
# # }

# # resource "azurerm_resource_group" "tf_test" {
# #   name     = data.azurerm_resource_group.existing_rg.name
# #   location = data.azurerm_resource_group.existing_rg.location
# #   lifecycle {
# #     prevent_destroy = true
# #   }
# # }