resource "kubernetes_replication_controller" "spring-frontend" {
  metadata {
    name = "spring-frontend"
    namespace = "k8s-go"
    labels {
      App = "spring-frontend"
    }
  }

  spec {
    replicas = 0
    selector {
      App = "spring-frontend"
    }
    template {
    service_account_name = "${kubernetes_service_account.spring.metadata.0.name}"
    container {
        image = "lanceplarsen/spring-vault-demo"
        image_pull_policy = "Always"
        name = "spring"
        volume_mount {
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
            name = "${kubernetes_service_account.spring.default_secret_name}"
            read_only = true
        }
        volume_mount {
            mount_path = "/bootstrap.yaml"
            sub_path = "bootstrap.yaml"
            name = "${kubernetes_config_map.spring.metadata.0.name}"
        }
        port {
            container_port = 8080
        }
    }
    volume {
        name = "${kubernetes_service_account.spring.default_secret_name}"
        secret {
            secret_name = "${kubernetes_service_account.spring.default_secret_name}"
        }
    }
    volume {
        name = "${kubernetes_config_map.spring.metadata.0.name}"
        config_map {
            name = "spring"
            items {
                key = "config"
                path =  "bootstrap.yaml"
            }
        }
    }
    }
  }
}

resource "kubernetes_service" "spring-frontend" {
    metadata {
        name = "spring-frontend"
        namespace = "k8s-go"
    }
    spec {
        selector {
            App = "${kubernetes_replication_controller.spring-frontend.metadata.0.labels.App}"
        }
        port {
            port = 8080
            target_port = 8080
        }
        type = "LoadBalancer"
    }
}

resource "kubernetes_config_map" "spring" {
  metadata {
    name = "spring"
    namespace = "k8s-go"
  }
  data {
    config = <<EOF
---
spring.cloud.vault:
    authentication: KUBERNETES
    kubernetes:
        role: order
        service-account-token-file: /var/run/secrets/kubernetes.io/serviceaccount/token
    host: 34.200.226.105
    port: 8200
    scheme: http
    fail-fast: true
    config.lifecycle.enabled: true
    database:
        enabled: true
        role: order
        backend: database
spring.datasource:
    url: jdbc:postgresql://llarsenvaultdb.cihgglcplvpp.us-east-1.rds.amazonaws.com:5432/postgres
EOF
  }
}
