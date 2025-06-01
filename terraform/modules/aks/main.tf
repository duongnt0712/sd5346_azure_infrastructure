resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.k8s_version
  node_resource_group = "aks_${var.cluster_name}_${var.location}"
  tags                = var.aks_tags

  default_node_pool {
    name           = "system"
    node_count     = 1
    vm_size        = "Standard_B2s"
    vnet_subnet_id = var.az_subnet_id

    only_critical_addons_enabled = true

    node_labels = {
      "worker-name" = "system"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = var.network_plugin
  }

  # enable workload identity
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  depends_on = [var.az_subnet_dependency]
}

resource "azurerm_kubernetes_cluster_node_pool" "k8s-worker" {
  for_each = var.nodepools

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = each.value.vm_size
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  vnet_subnet_id        = var.az_subnet_id
  tags                  = each.value.tags

  node_labels = each.value.node_labels
}
