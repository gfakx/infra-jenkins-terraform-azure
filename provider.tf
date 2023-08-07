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

# Define Azure authentication variables
variable "AZURE_SUBSCRIPTION_ID" {}
variable "AZURE_CLIENT_ID" {}
variable "AZURE_CLIENT_SECRET" {}
variable "AZURE_TENANT_ID" {}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = var.AZURE_SUBSCRIPTION_ID
  client_id       = var.AZURE_CLIENT_ID
  client_secret   = var.AZURE_CLIENT_SECRET
  tenant_id       = var.AZURE_TENANT_ID

  features {}
}