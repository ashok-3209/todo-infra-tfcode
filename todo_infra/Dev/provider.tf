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
  subscription_id = "c69268aa-c88b-494c-aa80-775984104d2a"

}
