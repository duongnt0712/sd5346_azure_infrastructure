output "frontend_image_repo_url" {
  value = module.frontend_ecr.repo_url
}

output "backend_image_repo_url" {
  value = module.backend_ecr.repo_url
}
