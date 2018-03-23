resource "google_container_node_pool" "ci" {
  name       = "ci"
  zone       = "${var.zone}"
  cluster    = "${google_container_cluster.ci.name}"
  node_count = 1

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
    master_auth {
        username = "${var.linux_admin_username}"
        password = "${var.linux_admin_password}"
    }

    lifecycle {
        ignore_changes = ["node_pool"]
    }

    node_pool {
        name = "default-pool"
    }

}

resource "google_compute_network" "gcn-ci" {
  name = "${var.cluster_ci_name}-${var.env}"
}

resource "google_compute_image" "ci-image" {
  name = "jenkins-home-image"

  raw_disk {
    source = "https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home-v3.tar.gz"
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
