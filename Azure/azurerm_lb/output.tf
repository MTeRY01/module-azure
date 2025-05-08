output "lb_private_ip" {
  value = azurerm_lb.load_balancer.frontend_ip_configuration[0].private_ip_address
}
