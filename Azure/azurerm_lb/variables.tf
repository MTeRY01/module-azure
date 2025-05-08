variable "name" {
  description = "Name of the load balancer"
  type        = string
  
}
variable "location" {
  description = "Location of the load balancer"
  type        = string
  
}
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  
}
# variable "ip_configuration_name" {
#   description = "Name of the IP configuration"
#   type        = string
  
# }
# variable "lb_private_ip" {
#   description = "ID of the public IP address"
#   type        = string
#   default     = null
  
# }
variable "api_nic_ids" {
  description = "List of NIC IDs for the API"
  type        = string  
  
}
variable "subnet_id" {
  description = "ID of the subnet for the API tier"
  type        = string
  
}