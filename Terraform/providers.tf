provider "azurerm" {
  features {}
        subscription_id = var.sp_subscription_id
        client_id       = var.sp_client_id
        client_secret   = var.sp_client_secret
        tenant_id       = var.sp_tenant_id

}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"

    }
  }
}