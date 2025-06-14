# ./gke/outputs.tf

# Expõe o nome do cluster para outros módulos usarem
output "name" {
  description = "Nome do cluster GKE criado."
  value       = google_container_cluster.primary.name
}

# Expõe o endpoint do cluster para conexão
output "endpoint" {
  description = "Endpoint do cluster GKE."
  value       = google_container_cluster.primary.endpoint
}

# Expõe o certificado de autoridade para conexão segura
output "ca_certificate" {
  description = "Certificado de autoridade do cluster GKE (codificado em base64)."
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive   = true
}