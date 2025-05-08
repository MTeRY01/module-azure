output "loadbalancer_ip" {
  value = azurerm_lb.backend_lb.private_ip_address
}


