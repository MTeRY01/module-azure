resource "azurerm_lb" "backend_lb" {
  name                = "backend-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"


  frontend_ip_configuration {
    name                          = "backend-lb-fe"
    subnet_id                     = var.subnet_id # Private subnet
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.5.4"
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.backend_lb.id
  name            = "backend-pool"
}

resource "azurerm_lb_probe" "http_probe" {
  name            = "http-probe"
  loadbalancer_id = azurerm_lb.backend_lb.id
  protocol        = "Tcp"
  port            = 3000
}

resource "azurerm_lb_rule" "http_rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.backend_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 3000
  backend_port                   = 3000
  frontend_ip_configuration_name = "backend-lb-fe"
  probe_id                       = azurerm_lb_probe.http_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
}


resource "azurerm_network_interface_backend_address_pool_association" "back_vm1_pool_assoc" {
  network_interface_id = var.backend_nic

  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

