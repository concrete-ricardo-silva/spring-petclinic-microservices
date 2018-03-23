resource "google_container_node_pool" "api" {
  name       = "api"
  zone       = "${var.zone}"
  cluster    = "${google_container_cluster.api.name}"
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    oauth_scopes = [
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring",
    ]
  }
}

resource "google_container_cluster" "api" {
    name               = "${var.cluster_name}-${var.env}"
    zone               = "${var.zone}"
    network            = "${google_compute_network.gcn-api.name}"
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

resource "google_compute_network" "gcn-api" {
  name = "${var.cluster_name}-${var.env}"
}

#resource "google_compute_global_address" "api" {
#  name = "${var.cluster_name}-${var.env}"
#}
