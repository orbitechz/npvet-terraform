
# NPVet · Provisionamento Multicloud com Terraform e Kubernetes

> Repositório de infraestrutura como código para **provisionamento de ambientes em nuvem com GKE** e gerenciamento Kubernetes via **Terraform**, com suporte a ambientes `staging` e `production`, pipelines GitHub Actions e separação clara de responsabilidades.

---

## Sumário

1. [Visão Geral](#visão-geral)
2. [Diagrama de Arquitetura](#diagrama-de-arquitetura)
3. [Objetivo da Entrega](#objetivo-da-entrega)
4. [Ambientes e Estrutura](#ambientes-e-estrutura)
5. [Tecnologias Utilizadas](#tecnologias-utilizadas)
6. [Infraestrutura Provisionada](#️infraestrutura-provisionada)  
7. [CI/CD com GitHub Actions](#cicd-com-github-actions)
8. [Etapas automatizadas](#etapas-automatizadas)
9. [Observabilidade](#observabilidade)
10. [Estrutura do Repositório](#estrutura-do-repositório)  
11. [Execução Local](#execução-local)  
12. [Recursos Complementares](#recursos-complementares)  

---

## Visão Geral

Este repositório contém a implementação de um projeto DevOps com foco em provisionamento automatizado de infraestrutura e aplicações em ambientes multicloud usando Terraform, Kubernetes e GitHub Actions. O ambiente de Staging é hospedado separadamente do ambiente de Produção, simulando cenários reais de resiliência e segregação.



## Diagrama de Arquitetura

A seguir, apresentamos o diagrama que representa a arquitetura da solução proposta. Ele ilustra os componentes de infraestrutura, automação e observabilidade entre os ambientes de Staging e Produção.

![Diagrama da Arquitetura](https://github.com/seu-usuario/npvet-terraform/blob/main/docs/diagrama-arquitetura.png)



## Objetivo da Entrega

- Provisionar dois ambientes isolados:
  - Staging: ambiente de homologação
  - Produção: ambiente final em nuvem distinta
- Automatizar todo o pipeline de deploy: infraestrutura + aplicação
- Implementar observabilidade com dashboards acessíveis
- Garantir que as quatro pipelines estejam funcionais:
  - Staging Frontend
  - Staging Backend
  - Produção Frontend
  - Produção Backend



## Ambientes e Estrutura

| Ambiente   | Orquestrador | Backend Terraform     | Diretórios Relacionados |
|------------|--------------|------------------------|--------------------------|
| Staging    | GKE (Google) | `staging.tfbackend`    | `gke/`, `kubernetes/`    |
| Produção   | GKE (Google) | `production.tfbackend` | `gke/`, `kubernetes/`    |


## Tecnologias Utilizadas

| Ferramenta     | Finalidade                                         |
|----------------|----------------------------------------------------|
| ![Terraform](https://img.shields.io/badge/Terraform-844FBA?logo=terraform&logoColor=white)     | Provisionamento de infraestrutura (IaC) |
| ![Kubernetes](https://img.shields.io/badge/Kubernetes-326ce5?logo=kubernetes&logoColor=white)   | Orquestração de contêineres             |
| ![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)         | Empacotamento de aplicações             |
| ![GCP](https://img.shields.io/badge/GCP-4285F4?logo=googlecloud&logoColor=white)             | Hospedagem do cluster Kubernetes        |
| ![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?logo=githubactions&logoColor=white) | Automatização de pipelines CI/CD        |
| ![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?logo=prometheus&logoColor=white) | Monitoramento do cluster e pods         |
| ![Grafana](https://img.shields.io/badge/Grafana-F46800?logo=grafana&logoColor=white)       | Dashboards de métricas                  |



## Infraestrutura Provisionada

- Clusters Kubernetes (GKE) distintos por ambiente
- Monitoramento com Prometheus e Grafana
- Provisionamento via Terraform
- Deploy de aplicações via Kubernetes
- Separação entre infraestrutura e camada de aplicação



## CI/CD com GitHub Actions

As pipelines estão definidas no diretório `.github/workflows/`:

- `deploy-staging.yaml`
- `deploy-production.yaml`

### Etapas automatizadas:

1. Inicialização e aplicação do Terraform (`init`, `plan`, `apply`)
2. Configuração do cluster e instalação de observabilidade
3. Build das aplicações (frontend e backend)
4. Dockerização e push para container registry
5. Deploy no cluster Kubernetes com `kubectl`
6. Validação por probes e endpoints



## Observabilidade

Cada ambiente possui seu próprio stack de monitoramento:

- Prometheus para coleta de métricas Kubernetes
- Grafana com dashboards configurados para:
  - Consumo de CPU e memória
  - Status de pods
  - Disponibilidade de serviços



## Estrutura do Repositório

```bash
npvet-terraform/
├── .github/workflows/
│   ├── deploy-staging.yaml
│   └── deploy-production.yaml
│
├── gke/
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
│
├── kubernetes/
│   ├── main.tf
│   ├── providers.tf
│   └── variables.tf
│
├── main.tf
├── staging.tfvars
├── production.tfvars
├── staging.tfbackend
├── production.tfbackend
├── terraform.tfvars.template
└── .gitignore
````



## Execução Local

Pré-requisitos:

* Conta GCP com permissões para criar clusters
* Ferramentas instaladas: `terraform`, `kubectl`, `docker`, `gh`, `helm`

Exemplo para provisionar ambiente de staging:

```bash
terraform init -backend-config=staging.tfbackend
terraform plan -var-file=staging.tfvars
terraform apply -var-file=staging.tfvars
```

Aplicar recursos Kubernetes:

```bash
kubectl apply -f kubernetes/
```

## Recursos Complementares

* [Terraform](https://developer.hashicorp.com/terraform/docs)
* [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine)
* [Prometheus](https://prometheus.io/)
* [Grafana](https://grafana.com/)
* [Docker](https://docs.docker.com/)


## Equipe

| Nome          | GitHub                                         |
| ------------- | ---------------------------------------------- |
| orbitechz |  [@orbitechz](https://github.com/orbitechz) |

