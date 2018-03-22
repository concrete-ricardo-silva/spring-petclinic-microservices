resource "google_container_node_pool" "np" {
  name       = "node-pool"
  zone       = "${var.zone}"
  cluster    = "${google_container_cluster.gcp_kubernetes.name}"
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

resource "google_container_cluster" "gcp_kubernetes" {
    name               = "${var.cluster_name}"
    zone               = "${var.zone}"
    master_auth {
        username = "${var.linux_admin_username}"
        password = "${var.linux_admin_password}"
    }
   
    node_pool {
       name = "default-pool"
    }
}

resource "google_compute_global_address" "default" {
  name = "global-apigateway-ip"
}

output "ip" {
  value = "${google_compute_global_address.default.name}"
}
