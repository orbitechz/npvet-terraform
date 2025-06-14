# ./kubernetes/variables.tf

variable "gke_cluster_name" {
  description = "Nome do cluster GKE para conexão."
  type        = string
}

variable "gke_cluster_endpoint" {
  description = "Endpoint do cluster GKE."
  type        = string
  sensitive   = true
}

variable "gke_cluster_ca_certificate" {
  description = "Certificado de autoridade do cluster GKE."
  type        = string
  sensitive   = true
}

variable "grafana_admin_password" {
  description = "Senha para o usuário 'admin' do Grafana."
  type        = string
  sensitive   = true
}