# invoke modules which creates resource group, network (vnet, subnets), acr and aks cluter
module "network" {
  source = "./modules/network"

  resource_group_name = var.cluster_name
  vnet_name           = var.cluster_name
  subnet_name         = var.cluster_name

  location = var.location

  address_space         = var.address_space
  subnet_address_prefix = var.address_space
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = var.cluster_name
  depends_on          = [module.network]
}

module "aks_with_node_group" {
  source = "./modules/aks"

  cluster_name        = var.cluster_name
  k8s_version         = var.k8s_version
  location            = var.location
  dns_prefix          = var.cluster_name
  resource_group_name = module.network.az_rg_name
  az_subnet_id        = module.network.az_subnet_id
  nodepools           = var.nodepools
  depends_on          = [module.network]
}
