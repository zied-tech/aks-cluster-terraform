provider "azurerm" {
  features {}
}

resource "azurerm_container_registry" "acr" {
  name                = "containerRegistryadactimzied"
  resource_group_name = var.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false
  storage_account_id       = "/subscriptions/8dad328f-8daa-4be3-96fa-4713fd77f8fa/resourceGroups/cloud-shell-storage-westeurope/providers/Microsoft.Storage/storageAccounts/csb10032001f02bce76"

}
resource "azurerm_kubernetes_cluster" "az-kc" {
  name                = "k8s-cluster"
  location            = var.location
  resource_group_name = var.name
  dns_prefix          = "aks-cluster-dns"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_B2s"
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }
  tags = {
    environment = "k8s-env"
  }
}

resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_kubernetes_cluster.az-kc.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}