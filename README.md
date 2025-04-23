
---

## ✅ Module Usage

Paste this into your `main.tf` file to deploy a basic VM setup using the reusable modules:

```hcl
module "resource_group" {
  source   = "../modules/module-azure/Azure/azurerm_resource_group"
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

module "vnet" {
  source              = "../modules/module-azure/Azure/azurerm_virtual_network"
  name                = local.virtual_network_name
  location            = module.resource_group.resource_group_location
  address_space       = local.vnet_address_space
  resource_group_name = module.resource_group.resource_group_name
  tags                = local.tags
}

module "subnet_frontend" {
  source              = "../modules/module-azure/Azure/azurem_subnets"
  name                = local.subnet_name_frontend
  vnet_name           = module.vnet.vnet_name
  address_prefixes    = local.subnet_address_prefixes_frontend
  resource_group_name = module.resource_group.resource_group_name
}

module "NSG" {
  source              = "../modules/module-azure/Azure/azurerm_network_security_group"
  nsg_name            = local.nsg_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}

module "nsg_rule" {
  source = "../modules/module-azure/Azure/azurerm_nsg_rule"
  for_each = local.nsg_rules

  name                       = each.key
  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix

  resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.NSG.network_security_group.name
}

module "public_ip_frontend" {
  source              = "../modules/module-azure/Azure/azurerm_public_ip"
  public_ip_name      = local.public_ip_name_frontend
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
}

module "nic_frontend" {
  source                    = "../modules/module-azure/Azure/azurerm_network_interface"
  nic_name                  = local.nic_name_front
  location                  = module.resource_group.resource_group_location
  resource_group_name       = module.resource_group.resource_group_name
  subnet_id                 = module.subnet_frontend.id
  public_ip_address_id      = module.public_ip_frontend.id
  network_security_group_id = module.NSG.network_security_group.id
}

module "vm_front" {
  source              = "../modules/module-azure/Azure/azurerm_linux_virtual_machine"
  vm_name             = local.vm_name_front
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  admin_username      = local.admin_username
  nic_id              = module.nic_frontend.id
}
