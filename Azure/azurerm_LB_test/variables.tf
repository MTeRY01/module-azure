variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "name" {
  type        = string
  description = "The name of the appgateway"
}

variable "location" {
  type        = string
  description = "Azure region"
}


variable "subnet_id" {
  
}

variable "backend_nic" {

  description = "List of backend IPs"
}




