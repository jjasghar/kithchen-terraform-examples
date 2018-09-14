provider "docker" {
  host    = "unix:///var/run/docker.sock"
}

data "docker_registry_image" "ubuntu" {
  name = "rastasheep/ubuntu-sshd:latest"
}

resource "docker_image" "ubuntu" {
  name          = "${data.docker_registry_image.ubuntu.name}"
  pull_triggers = ["${data.docker_registry_image.ubuntu.sha256_digest}"]
}

resource "docker_container" "ubuntu" {
  image    = "${docker_image.ubuntu.name}"
  name     = "ubuntu_container"

  ports {
    external = 2222
    internal = 22
  }
}