resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks-cluster"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  dns_prefix          = "${var.prefix}-dns"

  node_resource_group = "${var.prefix}-aks-node"

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.node_cont
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

 
}

