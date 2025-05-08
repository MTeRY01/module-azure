output "id" {
  description = "Map of NIC IDs keyed by their logical names"
  value = azurerm_network_interface.nic.id
}

output "nic" {
  description = "All NIC attributes keyed by logical names"
  value       = azurerm_network_interface.nic
}

# output "private_ip_addresses" {
#   description = "Map of private IP addresses keyed by their logical names"
#   value = { 
#     for k, nic in azurerm_network_interface.nic : 
#     k => nic.ip_configuration[0].private_ip_address 
#   }
# }

output "private_ip_address" {
    value = azurerm_network_interface.nic.private_ip_address
}
