variable "vmss_name" {
  description = "Name of the Virtual Machine Scale Set"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VMSS"
  type        = string
}

variable "public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for VMSS"
  type        = string
}

variable "vm_size" {
  description = "Size of the VMs in the scale set"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "instance_count" {
  description = "Number of VM instances"
  type        = number
  default     = 2
}
