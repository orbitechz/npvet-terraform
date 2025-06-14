# ./gke/variables.tf

variable "project_id" {
  description = "O ID do projeto GCP onde o cluster será criado."
  type        = string
}

variable "cluster_name" {
  description = "O nome do cluster GKE."
  type        = string
}

variable "region" {
  description = "A região do GCP para provisionar os recursos."
  type        = string
}