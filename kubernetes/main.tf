# ./kubernetes/main.tf

# Instala o pacote (chart) kube-prometheus-stack usando Helm 
data "google_compute_address" "grafana_staging_ip" {
    name = var.grafana_ip
    project = var.project_id
    region = var.region
}
resource "helm_release" "prometheus_stack" {
    name       = "promo-stack"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart      = "kube-prometheus-stack"

    # Cria um namespace dedicado para o monitoramento, mantendo a organização
    namespace        = "monitoring"
    create_namespace = true

    # Define valores para customizar a instalação
    values = [
        yamlencode({
            # Configurações do Grafana
            grafana = {
            # Define o usuário administrador padrão
                adminUser = "admin"
                
                # Usa a senha segura passada pela variável
                adminPassword = var.grafana_admin_password
                
                # Expõe o Grafana através de um IP externo usando um Load Balancer
                service = {
                    type = "LoadBalancer"
                    loadBalancerIP = data.google_compute_address.grafana_staging_ip.address
                }
            }
        })
    ]
}