provider "azurerm" {
features {}
}

resource "azurerm_resource_group" "bakhaissakhov" {
  name     = "rg-log-analyzer"
  location = "North Central US"
}

resource "azurerm_kubernetes_cluster" "bakhaissakhov" {
  name                = "bakhaissakhov-aks1"
  location            = azurerm_resource_group.bakhaissakhov.location
  resource_group_name = azurerm_resource_group.bakhaissakhov.name
  dns_prefix          = "bakhaissakhovaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.bakhaissakhov.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.bakhaissakhov.kube_config_raw
}

