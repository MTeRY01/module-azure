resource "azurerm_network_interface" "nic" {
  resource_group_name = var.resource_group_name
  location = var.location
  name = var.nic_name

  ip_configuration {
    name ="internal"
    subnet_id = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = var.public_ip_address_id #can be null aka for backend
  }

   
}
resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.network_security_group_id
}