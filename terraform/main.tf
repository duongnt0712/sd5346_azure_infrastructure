# invoke modules which creates network (vpc, subnets), ec2, ecr and eks cluter
locals {
  project     = "practical-devops"
  environment = "dev"
  owner       = "SD5346"
}

module "cluster" {
  source = "./cluster"

  region       = var.region
  cluster_name = var.cluster_name
  k8s_version  = var.k8s_version
}
