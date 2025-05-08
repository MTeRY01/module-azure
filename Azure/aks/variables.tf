variable "prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "mtAks"
  
}

variable "default_node_pool_name" {
  description = "Name of the default node pool"
  type        = string
  default     = "default"
  
}

variable "vm_size" {
  description = "Size of the VM for the default node pool"
  type        = string
  default     = "Standard_DS2_v2"
  
}

variable "node_cont" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 3
  
}