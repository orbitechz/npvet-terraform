# ./main.tf

# Declara as variáveis que o Terraform irá buscar no arquivo .tfvars
variable "project_id" {
  description = "ID do projeto no Google Cloud."
  type        = string
}

variable "region" {
  description = "Região GCP para provisionar os recursos."
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster a ser criado (ex: 'producao', 'homologacao')."
  type        = string
}

variable "grafana_admin_password" {
  description = "Senha para o usuário 'admin' do Grafana."
  type        = string
  sensitive   = true
}

variable "gke_zone" {
  description = "Zona GCP específica para o cluster GKE (ex: us-central1-a)."
  type        = string
}

terraform {
  backend "gcs" {}
}

# Configura o provedor do Google Cloud com as variáveis de entrada
provider "google" {
  project = var.project_id
  region  = var.region
}

# Módulo para provisionar a infraestrutura (Cluster Kubernetes) 
module "gke_cluster" {
  source       = "./gke"
  project_id   = var.project_id
  cluster_name = var.cluster_name
  region       = var.region
  zone         = var.gke_zone
}

# Módulo para configurar o Kubernetes (instalar Prometheus + Grafana) 
module "kubernetes_config" {
  # Garante que o cluster exista antes de tentar configurar
#   depends_on = [module.gke_cluster]

  source = "./kubernetes"

  # Passa as informações do cluster criado para o módulo de configuração
  gke_cluster_name           = module.gke_cluster.name
  gke_cluster_endpoint       = module.gke_cluster.endpoint
  gke_cluster_ca_certificate = module.gke_cluster.ca_certificate
  grafana_admin_password     = var.grafana_admin_password
}