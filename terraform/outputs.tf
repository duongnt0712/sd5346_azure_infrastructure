output "kube_config" {
  description = "Raw Kubernetes config to be used by kubectl and other compatible tools."
  value       = module.aks_with_node_group.kube_config
  sensitive   = true
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL that is associated with the cluster"
  value       = module.aks_with_node_group.oidc_issuer_url
}
