variable "cluster_name" {
  type        = string
  description = "aks cluster name"
}

variable "k8s_version" {
  type        = string
  description = "kubernetes version"
  default     = "1.32.4"
}

variable "location" {
  type        = string
  description = "azure location/region where the aks cluster must be created, this location/region should match where you have created the resource group, vnet and subnet"
}

variable "resource_group_name" {
  type        = string
  description = "azure resource group name where the aks cluster should be created"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix specified when creating the managed cluster. Possible values must begin and end with a letter or number, contain only letters, numbers, and hyphens and be between 1 and 54 characters in length. Changing this forces a new resource to be created."
  default     = "platformwale"
}

variable "az_subnet_id" {
  type        = string
  description = "azure subnet id where the nodepools and aks cluster need to be created"
}

variable "az_subnet_dependency" {
  description = "azure subnet id where the nodepools and aks cluster need to be created"
}

variable "network_plugin" {
  type        = string
  description = "Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created."
  default     = "azure"
}

variable "aks_tags" {
  type        = map(any)
  description = "tags for the aks cluster"
  default     = {}
}

variable "nodepools" {
  description = "Nodepools for the Kubernetes cluster"
  type = map(object({
    name                  = string
    vm_size               = string
    min_count             = number
    max_count             = number
    enable_auto_scaling   = bool
    enable_node_public_ip = bool
    tags                  = map(string)
    node_labels           = map(string)
  }))
  default = {
    worker = {
      name                  = "worker"
      vm_size               = "Standard_D2_v2"
      min_count             = null
      max_count             = null
      enable_auto_scaling   = false
      enable_node_public_ip = true
      tags                  = { worker_name = "worker" }
      node_labels           = { "worker-name" = "worker" }
    }
  }
}
