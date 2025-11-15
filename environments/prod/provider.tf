terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Ritesh-oct"
    storage_account_name = "riteshoct"
    container_name       = "rit"
    key                  = "dev.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a43b4ce1-c640-4e6f-9491-095b358dc333"
}
