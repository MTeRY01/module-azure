variable "bastion_name" {
  description = "Name of the bastion host"
  type        = string
  
}   
variable "location" { 
  description = "Location of the bastion host"
  type        = string
  default     = "East US"
  
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  
}
variable "subnet_id" {
  description = "ID of the subnet where the bastion host will be deployed"
  type        = string
  
}
variable "public_ip_address_id" {
  description = "ID of the public IP address for the bastion host"
  type        = string
  
}