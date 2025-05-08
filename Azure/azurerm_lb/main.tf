# resource "azurerm_lb" "load_balancer" {
#   name                = var.name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku                 = "Standard"

#   frontend_ip_configuration {
#     name                            = "internalFrontend"
#     private_ip_address              = var.lb_private_ip  # Private IP for the Load Balancer
#     private_ip_address_allocation   = "Static"           # You can choose 'Dynamic' or 'Static'
#     subnet_id                       = var.subnet_id      # Subnet for internal communication
#   }
# }

# resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
#   name                = var.name_pool
#   loadbalancer_id     = azurerm_lb.load_balancer.id
# }

# # Associate NICs with Backend Pool (optional, if needed)
# resource "azurerm_network_interface_backend_address_pool_association" "backend_association" {
#   for_each                = var.backend_nic_ids
#   network_interface_id    = each.value
#   ip_configuration_name   = var.ip_configuration_name
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
# }

# resource "azurerm_lb_outbound_rule" "internet" {
#   name                    = "AllowInternetOutbound"
#   loadbalancer_id         = azurerm_lb.load_balancer.id
#   protocol                = "All"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id

#   frontend_ip_configuration {
#     name = azurerm_lb.load_balancer.frontend_ip_configuration[0].name
#   }
# }



# # Internal LB for API tier only
# resource "azurerm_lb" "load_balancer" {
#   name                = var.name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku                 = "Standard"  # Must be Standard for outbound rules(even for internal LB)

#   frontend_ip_configuration {
#     name                          = "internalFrontend"
#     private_ip_address            = var.lb_private_ip  # Static IP in API subnet
#     private_ip_address_allocation = "Static"
#     subnet_id                     = var.subnet_id      # API subnet
#   }

#     frontend_ip_configuration {
#     name                          = "outboundFrontend"
#     public_ip_address_id          = azurerm_public_ip.lb_outbound_ip.id
#   }
# }

# resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
#   name            = var.name_pool
#   loadbalancer_id = azurerm_lb.load_balancer.id
# }

# # Critical: Add a public IP for outbound NAT (even though LB is internal)
# resource "azurerm_public_ip" "lb_outbound_ip" {
#   name                = "${var.name}-outbound-ip"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Static"
#   sku                 = "Standard"  # Must match LB SKU
# }



# # Outbound rule 
# resource "azurerm_lb_outbound_rule" "internet" {
#   name                    = "AllowInternetOutbound"
#   loadbalancer_id         = azurerm_lb.load_balancer.id
#   protocol                = "All"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id

#   # Must reference the PUBLIC IP frontend
#   frontend_ip_configuration {
#     name = "outboundFrontend"
#   }
# }

# # NIC associations (no changes needed)
# resource "azurerm_network_interface_backend_address_pool_association" "backend_association" {
#   for_each                = var.backend_nic_ids
#   network_interface_id    = each.value
#   ip_configuration_name   = var.ip_configuration_name
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
# }




resource "azurerm_lb" "load_balancer" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"  #testing if this works for internal LB

  frontend_ip_configuration {
    name                 = "internal_ui_api"
    # private_ip_address            = var.lb_private_ip
    #private_ip_address_allocation = "Static"
    subnet_id                     = var.subnet_id #subnet for backend tier


  }
  
}
resource "azurerm_lb_probe" "lb_probe" { #<-- lb needs to have a FrontEnd IP Configuration Attached
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "api-health-probe"
  port            = 3000 #port for the backend  
  protocol        = "Tcp" #protocol for the backend health check
}

###test if this is needed
resource "azurerm_lb_backend_address_pool" "backend_pool" { #<-- lb needs to have a FrontEnd IP Configuration Attached
  name            = "BackEndAddressPool"
  loadbalancer_id = azurerm_lb.load_balancer.id
}



resource "azurerm_lb_rule" "api_rule" { #<-- lb needs to have a FrontEnd IP Configuration Attached
  loadbalancer_id                = azurerm_lb.load_balancer.id
  name                           = "internal_ui_api_rule"
  protocol                       = "Tcp"
  frontend_port                  = 3000   #AKA ui
  backend_port                   = 3000 #aka api /the backend
  frontend_ip_configuration_name = "internal_ui_api"
  probe_id                       = azurerm_lb_probe.lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
}
resource "azurerm_network_interface_backend_address_pool_association" "api" {
    
  network_interface_id    = var.api_nic_ids
  ip_configuration_name   = "internal"  # must match NIC configuration name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}