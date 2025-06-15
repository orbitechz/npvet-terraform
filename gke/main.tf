# ./gke/main.tf

# Declara as variáveis que o módulo espera receber.
# Provisiona o cluster GKE já com seu pool de nós configurado.
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.zone

  # --- ALTERAÇÕES PRINCIPAIS ---
  deletion_protection = false

  # 1. Não vamos mais remover o pool de nós padrão.
  remove_default_node_pool = false

  # 2. Definimos o número de nós diretamente aqui.
  initial_node_count = 2

  # 3. Este bloco agora configura o pool de nós permanente do cluster.
  node_config {
    machine_type = "e2-medium"
    disk_type    = "pd-standard"
    disk_size_gb = 100

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# 4. O recurso 'google_container_node_pool' separado foi REMOVIDO,
# pois não é mais necessário.