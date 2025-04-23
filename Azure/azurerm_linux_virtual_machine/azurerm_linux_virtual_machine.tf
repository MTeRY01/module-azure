
resource "azurerm_linux_virtual_machine" "VM" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2s_v3"
  admin_username      = var.admin_username
  admin_password = "Aa1212121212"
  disable_password_authentication = false
  network_interface_ids = [
    var.nic_id,
  ]

admin_ssh_key {
    username   = var.admin_username
    public_key = file("${path.root}/../ansible_project/keys/id_rsa.pub")  
}


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}