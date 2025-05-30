locals {
  project     = "practical-devops"
  environment = "dev"
  owner       = "SD5346"
}

module "frontend_ecr" {
  source = "../modules/ecr"
  name   = "frontend"

  project     = local.project
  environment = local.environment
  owner       = local.owner
}

module "backend_ecr" {
  source = "../modules/ecr"
  name   = "backend"

  project     = local.project
  environment = local.environment
  owner       = local.owner
}
