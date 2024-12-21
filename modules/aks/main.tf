# Subscription Data Source
data "azurerm_subscription" "current" {}

# Define the AKS Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-cluster-${var.app_name}"
  location            = var.location
  resource_group_name = var.resource_group.name
  dns_prefix          = "aks-${var.app_name}"
  sku_tier            = var.sku_tier
  kubernetes_version  = var.kubernetes_version
  network_profile {
    network_plugin = var.network_plugin
  }

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name            = "default"
    type            = "VirtualMachineScaleSets"
    node_count      = var.default_pool_node_count
    vm_size         = var.default_nodepool_vm_size
    vnet_subnet_id  = var.subnet_id
    os_disk_size_gb = var.os_disk_size_gb
    zones           = var.default_pool_agents_availability_zones
    node_labels     = var.default_labels_static
    max_pods        = var.aks_max_pod_number
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "additional_pools" {
  for_each              = { for idx, np in var.node_pools : np.name => np }
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  orchestrator_version  = each.value.orchestrator_version
  name                  = each.value.name
  os_disk_size_gb       = each.value.os_disk_size_gb
  vnet_subnet_id        = var.subnet_id
  auto_scaling_enabled  = each.value.auto_scaling_enabled
  node_count            = each.value.node_count
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  zones                 = each.value.zones
  vm_size               = each.value.vm_size
  os_type               = each.value.os_type
  mode                  = each.value.mode
  node_taints           = each.value.taints
  node_labels            = each.value.taints
  tags                  = each.value.tags
}
