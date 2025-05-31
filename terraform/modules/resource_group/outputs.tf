output "az_rg_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.az_rg.id
}

output "az_rg_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.az_rg.name
}

output "az_rg_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.az_rg.location
}
