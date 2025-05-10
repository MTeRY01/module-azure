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

# Helm provider (uses kubectl from AKS)
provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
    client_key            = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
  }
}

# Install NGINX Ingress with Helm
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  create_namespace = true

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "controller.ingressClassResource.name"
    value = "nginx"
  }
  lifecycle {
    ignore_changes = [
      repository,  # Ignore changes to the Helm repo URL
      chart,       # Ignore changes to the chart name
      version,     # Ignore version updates
      set,         # Ignore changes to `set` blocks
      values       # Ignore changes to `values` files
    ]
  }
} 

