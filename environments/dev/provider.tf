terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Ritesh-oct"
    storage_account_name = "riteshnov"
    container_name       = "rit"
    key                  = "devinfra.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
  }
  }
  subscription_id = "5e63e763-8324-4d7c-b1f3-78689fc7dacc"
}
