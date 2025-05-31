variable "acr_name" {
  type        = string
  description = "The name of the Azure Container Registry. This is used to store container images."
}

variable "resource_group_name" {
  type        = string
  description = "The Name for this Resource Group. Changing this forces a new Resource Group to be created."
}

variable "location" {
  type        = string
  description = "The location/region where the resource group. Changing this forces a new resource to be created. We will create the vnet and subnets in the same location/region where the resource group is."
}
