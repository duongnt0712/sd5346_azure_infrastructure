# invoke modules which creates resource group, network (vnet, subnets), acr and aks cluter
module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.cluster_name
  location            = var.location
}

module "network" {
  source = "./modules/network"

  vnet_name           = var.cluster_name
  subnet_name         = var.cluster_name
  location            = module.resource_group.az_rg_location
  resource_group_name = module.resource_group.az_rg_name

  address_space         = var.address_space
  subnet_address_prefix = var.address_space
  depends_on            = [module.resource_group]
}

module "acr" {
  source = "./modules/acr"

  acr_name            = var.acr_name
  location            = module.resource_group.az_rg_location
  resource_group_name = module.resource_group.az_rg_name
  depends_on          = [module.resource_group, module.network]
}

module "aks_with_node_group" {
  source = "./modules/aks"

  cluster_name         = var.cluster_name
  k8s_version          = var.k8s_version
  dns_prefix           = var.cluster_name
  location             = module.resource_group.az_rg_location
  resource_group_name  = module.resource_group.az_rg_name
  az_subnet_id         = module.network.az_subnet_id
  nodepools            = var.nodepools
  az_subnet_dependency = module.network.subnet_resource
  depends_on           = [module.resource_group, module.network, module.acr]
}
