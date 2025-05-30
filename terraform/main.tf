# invoke modules which creates network (vpc, subnets), ec2, ecr and eks cluter
locals {
  project     = "practical-devops"
  environment = "dev"
  owner       = "SD5346"
}

module "network-tags" {
  source = "./modules/tags"
  name   = "practical-devops-network-tags"

  project     = local.project
  environment = local.environment
  owner       = local.owner
}

module "network" {
  source = "./modules/network"
  name   = "practical-devops-network"

  vpc_cidr               = "10.0.0.0/16"
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = module.network-tags.tags
}

module "ecr" {
  source = "./ecr"
}

module "ec2" {
  source = "./ec2"
}

module "eks" {
  source           = "./modules/eks"
  eks_cluster_name = "practical-devops-eks"

  vpc_id                     = module.network.vpc_id
  eks_node_groups_subnet_ids = module.network.private_subnets
  control_plane_subnet_ids   = module.network.private_subnets
}
