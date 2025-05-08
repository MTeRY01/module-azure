variable "resource_group_name" {    
  description = "Name of the resource group"
  type        = string
  
}

variable "nic_name" {    
  description = "Name of the network interface"
  type        = string
  
}

variable "location" {    
  description = "Location of the resource group"
  type        = string
  
}

variable "subnet_id" {    
  description = "ID of the subnet"
  type        = string
  
}

variable "public_ip_address_id" {    
  description = "ID of the public IP address"
  type        = string
  default     = null
}

variable "network_security_group_id" {    
  description = "ID of the network security group"
  type        = string
  default     = null
  
}

# variable "backend_pool_id" {    
#   description = "ID of the backend address pool"
#   type        = string
#   default     = null
  
# }

# variable "nic_names_map" {
#   type        = map(string)
#   description = "Map of NIC configurations (key = logical name, value = NIC name)"
# }
