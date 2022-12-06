resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "kv" {
  name                       = "djangobloggerfirstKV"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
        subscription_id = var.sp_subscription_id
        client_id       = var.sp_client_id
        client_secret   = var.sp_client_secret
        tenant_id       = var.sp_tenant_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}
resource "azurerm_key_vault_secret" "se" {
  name         = "sshsecret"
  value        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkcMenCHH3DZ4I6CponoJqv1fnk+cTv9LeybYJHwABj+PH/TVGJKBzI7vMi7/faScPONXcDvGxQG3iQndToOb5xKO77BlznecnfWTK8JhTkTbUUx3Jp4nrFZlYSOABrFNP9MLkQnkq8FfRfKQiO8jluq+hao9xbe9ahvv3Lwzt3G8AJCrxwW72Mm0gt5sVhi5Wklujj5wAhhQkzI3JTZgEBl0vfNSQ0+bFfyMOh/nxTJbV3fK1D1f5CGo+PMD3XVsJ1KRqTG3DSKQQporILlmp3jQFvnUp4GzHG7m7p/7abZtq1dt1uKeVRVDQLd6TLfNKdiKn6krdUh9a+jWd7R5p rakesh@cc-f619f4f3-56b44bbc48-4mf8f"
  key_vault_id = azurerm_key_vault.kv.id
}


data "azurerm_key_vault" "kv" {
  name                = "djangobloggerfirstKV" // KeyVault name
  resource_group_name = var.resource_group_name // resourceGroup
}

data "azurerm_key_vault_secret" "se" {
name = "sshsecret" // Name of secrett
key_vault_id = data.azurerm_key_vault.kv.id
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
  node_resource_group = var.node_resource_group

    linux_profile {
        admin_username = "ubuntu"

         ssh_key {
            key_data  = data.azurerm_key_vault_secret.se.value // Toget actual value
        }
        
    }

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_B2s"
    type                = "VirtualMachineScaleSets"
    #availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" # azure (CNI)
  }
}