variable "name" {
    description = "Name of the Application Gateway"
    type        = string
}
variable "resource_group_name" {
    description = "Name of the resource group in which to create the Application Gateway"
    type        = string
}
variable "location" {
    description = "Location of the Application Gateway"
    type        = string
}
variable "subnet_id" {
    description = "ID of the subnet in which to create the Application Gateway"
    type        = string
}
variable "backend_address_pool_name" {
  type        = string
  description = "List of backend IP addresses for the Application Gateway."
 
}

variable "backend_ip_addresses" {
  type        = set(string)
  description = "Set of backend IP addresses for the Application Gateway."
}

variable "public_ip_id" {
  type = string
}
variable "private_ip_addresses" {
  type        = map(string)
  description = "Map of private IP addresses keyed by logical names"
  default     = {}
  
}
variable "healthy_threshold" {
  type        = number
  description = "The number of successful probes required before a backend instance is considered healthy."
  default     = 2
  
}
variable "pick_host_name_from_backend" {
  type        = bool
  description = "Whether to pick the host name from the backend pool."
  default     = false
  
}

variable "min_servers" {
  type        = number
  description = "The minimum number of servers in the backend pool."
  default     = 0
  
}