resource "kubernetes_namespace" "example" {
  metadata {
    name = var.namespace
    annotations = {
      name = "example-annotation"
    }

    labels = {
      mylabel = "label-value"
    }

  }
}

resource "kubernetes_resource_quota" "podlimit" {
  metadata {
    name = "podlimit"
    namespace = var.namespace
  }
  spec {
    hard = {
      pods = var.podlimit
    }
    scopes = ["BestEffort"]
  }
}

resource "kubernetes_limit_range" "example" {
  metadata {
    name = "terraform-example"
    namespace = var.namespace
  }
  spec {
    limit {
      type = "Pod"
      max = {
        cpu    = "2000m"
        memory = "4Gi"
      }
    }
    limit {
      type = "Container"
      default = {
        cpu    = "500m"
        memory = "2Gi"
      }
    }
  }
}
