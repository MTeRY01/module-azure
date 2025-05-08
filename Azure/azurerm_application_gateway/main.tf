resource "azurerm_application_gateway" "ALB" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = var.public_ip_id
  }

  frontend_port {
    name = "frontend-port" # Port 80
    port = 80
  }

  frontend_port {
    name = "frontend-port-3000" # New port 3000
    port = 3000
  }

  backend_address_pool {
    name         = var.backend_address_pool_name
    ip_addresses = var.backend_ip_addresses  
  }

  backend_http_settings {
    name                                = "backend-http-settings"
    cookie_based_affinity               = "Disabled"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 20
    probe_name                          = "ui-health-probe"
    pick_host_name_from_backend_address = true
  }

  backend_http_settings {
    name                                = "backend-http-settings-3000"
    cookie_based_affinity               = "Disabled"
    port                                = 3000
    protocol                            = "Http"
    request_timeout                     = 20
    probe_name                          = "http-probe-3000"
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "http-listener-3000"   # New listener
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "frontend-port-3000"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    priority                   = 100  
    http_listener_name         = "http-listener"
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = "backend-http-settings"
  }

  request_routing_rule {
    name                       = "rule2"
    rule_type                  = "Basic"
    priority                   = 101  
    http_listener_name         = "http-listener-3000"
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = "backend-http-settings-3000"
  }

  probe {
    name                                      = "ui-health-probe"
    protocol                                  = "Http"
    path                                      = "/"
    pick_host_name_from_backend_http_settings = true
    interval                                  = 30
    timeout                                   = 10
    unhealthy_threshold                       = 3
    match {
      status_code = ["200"]
    }
  }

  probe {
    name                                      = "http-probe-3000"
    protocol                                  = "Http"
    path                                      = "/"
    pick_host_name_from_backend_http_settings = true
    port                                      = 3000
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
  }
}
