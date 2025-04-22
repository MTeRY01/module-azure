variable "resource_group_name" { 
  description = "The name of the resource group in which to create the virtual machine."
  type        = string
  
}

variable "location" { 
  description = "The Azure location where the virtual machine will be created."
  type        = string
  
}

variable "vm_name" { 
  description = "The name of the virtual machine."
  type        = string
  
}

variable "admin_username" { 
  description = "The username for the virtual machine administrator."
  type        = string
  
}

variable "nic_id" { 
  description = "The ID of the network interface to associate with the virtual machine."
  type        = string
  
}