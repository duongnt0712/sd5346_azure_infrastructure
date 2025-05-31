module "resource_group" {
  source              = "../resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_virtual_network" "az_vnet" {
  name                = var.vnet_name
  location            = module.resource_group.az_rg_location
  resource_group_name = module.resource_group.az_rg_name
  address_space       = var.address_space
  depends_on          = [module.resource_group]
}

resource "azurerm_subnet" "az_subnet" {
  name                 = var.subnet_name
  resource_group_name  = module.resource_group.az_rg_name
  virtual_network_name = resource.azurerm_virtual_network.az_vnet.name
  address_prefixes     = var.subnet_address_prefix
  service_endpoints    = var.service_endpoints
}
