resource "helm_release" "prometheus" {
  chart      = "prometheus"
  cleanup_on_fail = true
  name       = "prometheus"
  recreate_pods = true
  repository = "https://prometheus-community.github.io/helm-charts"
  replace = true
  set = [
    {
      name  = "service.type"
      value = "NodePort"
    }
  ]
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  depends_on = [helm_release.prometheus]
  set = [
    {
      name  = "service.type"
      value = "ClusterIP"
    },
    {
      name  = "persistence.enabled"
      value = "false"
    },
    {
      name  = "adminPassword"
      value = "admin"
    },
    {
      name  = "service.nodePort"
      value = "30080"
    }
  ]
  recreate_pods = true
  replace = true
}

resource "docker_image" "server_ping_image" {
  build {
    context    = "${path.module}/../server-ping"
    dockerfile = "Dockerfile"
  }
  depends_on = [ helm_release.prometheus ]
  name = "server-ping:latest"
}

resource "helm_release" "server_ping" {
  chart = "${path.module}/charts/server-ping"
  cleanup_on_fail = true
  depends_on = [ docker_image.server_ping_image ]
  force_update = true
  name = "server-ping"
  recreate_pods = true
  replace = true
}

resource "docker_image" "server_pong_image" {
  build {
    context    = "${path.module}/../server-pong"
    dockerfile = "Dockerfile"
  }
  depends_on = [ helm_release.prometheus ]
  name = "server-pong:latest"
}

resource "helm_release" "server_pong" {
  chart = "${path.module}/charts/server-pong"
  cleanup_on_fail = true
  depends_on = [ docker_image.server_pong_image ]
  force_update = true
  name = "server-pong"
  recreate_pods = true
  replace = true
}

resource "helm_release" "kube-state-metrics" {
  chart = "kube-state-metrics"
  cleanup_on_fail = true
  depends_on = [
    helm_release.server_ping,
    helm_release.server_pong
  ]
  name = "kube-state-metrics"
  recreate_pods = true
  repository = "https://prometheus-community.github.io/helm-charts"
  replace = true
}

resource "helm_release" "node_exporter" {
  chart      = "prometheus-node-exporter"
  cleanup_on_fail = true
  depends_on = [
    helm_release.server_ping,
    helm_release.server_pong
  ]
  name       = "prometheus-node-exporter"
  recreate_pods = true
  replace = true
  repository = "https://prometheus-community.github.io/helm-charts"
}
