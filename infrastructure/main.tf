resource "docker_image" "server_ping_image" {
  name = "server-ping:latest"
  build {
    context    = "${path.module}/../server-ping"
    dockerfile = "Dockerfile"
  }
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
  name = "server-pong:latest"
  build {
    context    = "${path.module}/../server-pong"
    dockerfile = "Dockerfile"
  }
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

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  depends_on = [helm_release.prometheus]
}
