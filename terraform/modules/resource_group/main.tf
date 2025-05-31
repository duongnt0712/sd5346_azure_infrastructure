resource "azurerm_resource_group" "az_rg" {
  name     = var.resource_group_name
  location = var.location
}
