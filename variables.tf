variable "k8s_endpoint" {
  description = "k8s_endpoint"
}

variable "k8s_master_auth_client_certificate" {
  description = "k8s_master_auth_client_certificate"
}

variable "k8s_master_auth_client_key" {
  description = "k8s_master_auth_client_key"
}

variable "k8s_master_auth_cluster_ca_certificate" {
  description = "k8s_master_auth_cluster_ca_certificate"
}

variable "instance_count" {
  default = 0
}

variable "vault_host" {
  description = "vault_server"
  default     = "localhost"
}

variable "vault_port" {
  description = "vault_port"
  default     = "8200"
}

variable "vault_scheme" {
  description = "scheme"
  default     = "http"
}

variable "vault_role" {
  description = "vault_role"
  default     = "order"
}

variable "postgres_host" {
  description = "postgres_server"
  default     = "localhost"
}

variable "postgres_port" {
  description = "postgres_port"
  default     = "5432"
}

variable "postgres_instance" {
  description = "postgres_instance"
  default     = "postgres"
}

variable "postgres_role" {
  description = "postgres_role"
  default     = "database/creds/order"
}

variable "spring_docker_container" {
  description = "spring_docker_container"
  default     = "lanceplarsen/spring-vault-demo"
}

variable "go_docker_container" {
  description = "go_docker_container"
  default     = "lanceplarsen/go-vault-demo"
}

variable "vault_mount" {
  default = "kubernetes"
}

variable "postgres_mount" {
  default = "database"
}
