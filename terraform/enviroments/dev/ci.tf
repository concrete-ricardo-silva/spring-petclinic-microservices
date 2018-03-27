resource "google_container_node_pool" "ci" {
  name       = "ci-pool"
  zone       = "${var.zone}"
  cluster    = "${google_container_cluster.ci.name}"
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = "n1-standard-2"

    oauth_scopes = [
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring",
    ]
  }
}

resource "google_container_cluster" "ci" {
    name               = "${var.cluster_ci_name}-${var.env}"
    zone               = "${var.zone}"
    network            = "${google_compute_network.gcn-ci.name}"
    initial_node_count = 2

    master_auth {
        username = "${var.linux_admin_username}"
        password = "${var.linux_admin_password}"
    }
}

resource "google_compute_network" "gcn-ci" {
  name = "${var.cluster_ci_name}-${var.env}"
}

resource "google_compute_image" "ci-image" {
  name = "jenkins-home-image"

  raw_disk {
    source = "https://github.com/concrete-felipe-rovai/petclinic/master/blob/jenkins-disk.tar.gz"
  }
}

resource "google_compute_disk" "default" {
  name  = "jenkins-home"
  zone  = "${var.zone}"
  image = "${google_compute_image.ci-image.name}"
}

resource "google_compute_global_address" "ci" {
  name = "${var.cluster_ci_name}-${var.env}"
}
