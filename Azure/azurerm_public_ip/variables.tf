variable "resource_group_name" {
  description = "The name of the resource group in which to create the public IP."
  type        = string
  
}
variable "location" {
  description = "The Azure location where the public IP will be created."
  type        = string
  default     = "East US"
  
}

variable "public_ip_name" {
  description = "The name of the public IP resource."
  type        = string
  default     = "myPublicIP"
  
}
