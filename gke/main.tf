# ./gke/main.tf

# Provisiona o cluster GKE
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id

  remove_default_node_pool = true
  initial_node_count       = 1

  # Utiliza a rede padrão do GCP para simplificar
  network    = "default"
  subnetwork = "default"

  # --- ADICIONE ESTE BLOCO AQUI ---
  # Define a configuração de nó padrão para o próprio cluster,
  # garantindo que qualquer nó temporário ou de controle use o disco correto.
  node_config {
    disk_type    = "pd-standard"
    disk_size_gb = 100
  }
  # -----------------------------------
}

# Cria um pool de nós gerenciado e dedicado para nossas aplicações
resource "google_container_node_pool" "primary_nodes" {
  name     = "${google_container_cluster.primary.name}-node-pool"
  location = var.region
  cluster  = google_container_cluster.primary.name
  
  node_count = 2

  node_config {
    machine_type = "e2-medium"
    disk_type    = "pd-standard"
    disk_size_gb = 100

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}