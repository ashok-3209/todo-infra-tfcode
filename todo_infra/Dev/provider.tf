terraform {
  required_version = ">= v1.12.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.31.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "6f5b9c3c-7e8b-46f5-a7be-c171cf606a91"

}