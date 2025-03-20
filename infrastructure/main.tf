resource "docker_image" "server_ping_image" {
  name = "server-ping:latest"
  build {
    context    = "${path.module}/../server-ping"
    dockerfile = "Dockerfile"
  }
}

resource "helm_release" "server_ping" {
  name = "server-ping"
  chart = "${path.module}/charts/server-ping"
  depends_on = [ docker_image.server_ping_image ]
  recreate_pods = true
}
