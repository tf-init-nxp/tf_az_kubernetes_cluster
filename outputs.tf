output "client_certificate" {
  value       = tostring(azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_certificate)
  sensitive   = true
  description = "Kubernetes Client Certificate"
}

output "cluster_ca_certificate" {
  value       = tostring(azurerm_kubernetes_cluster.aks_cluster.kube_config[0].cluster_ca_certificate)
  sensitive   = true
  description = "Kubernetes CA Certificate"
}

output "client_key" {
  value       = tostring(azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_key)
  sensitive   = true
  description = "Kubernetes Client Key"
}

output "host" {
  value       = tostring(azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host)
  description = "Kubernetes Host"
}

output "username" {
  value       = tostring(azurerm_kubernetes_cluster.aks_cluster.kube_config[0].username)
  description = "Kubernetes Username"
}


output "password" {
  value       = tostring(azurerm_kubernetes_cluster.aks_cluster.kube_config[0].password)
  sensitive   = true
  description = "Kubernetes Password"
}


output "principal_id" {
  value       = tostring(azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id)
  description = "Kubernetes Principal ID"
}

output "tenant_id" {
  value       = tostring(azurerm_kubernetes_cluster.aks_cluster.identity[0].tenant_id)
  description = "Kubernetes Tenand ID"
}

output "kube_config" {
  value       = tostring(azurerm_kubernetes_cluster.aks_cluster.kube_config_raw)
  sensitive   = true
  description = "Kubernetes Kubeconfig"
}

output "outbound_ip" {
  value       = tostring(element(split("/", join("-", flatten(azurerm_kubernetes_cluster.aks_cluster.network_profile[*].load_balancer_profile[*].effective_outbound_ips))), length(split("/", join("-", flatten(azurerm_kubernetes_cluster.aks_cluster.network_profile[*].load_balancer_profile[*].effective_outbound_ips)))) - 1))
  description = "Kubernetes Outbound IP Address"
}

output "node_resource_group" {
  value       = tostring(azurerm_kubernetes_cluster.aks_cluster.node_resource_group)
  description = "Kubernetes Resource Group MC"
}
