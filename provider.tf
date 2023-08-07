terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  #  backend "azure" {
  #    resource_group_name = "gfaxkrg"
  #    storage_account_name = "gfakx"
  #    container_name = "gfakxcontainer"
  #    key = "prod.terra.tfstate"
  #  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

