
resource "google_compute_network" "api-network" {
  name = "${var.cluster_api_name}-${var.env}"
}

resource "google_compute_global_address" "api" {
  name = "${var.cluster_api_name}-${var.env}"
}

resource "google_container_cluster" "cluster" {
  name               = "${var.cluster_api_name}-${var.env}"
  zone               = "${var.zone}"
  network            = "${google_compute_network.api-network.name}"
  initial_node_count = 1
   master_auth {
        username = "${var.linux_admin_username}"
        password = "${var.linux_admin_password}"
    }
}

resource "google_container_node_pool" "pool" {
  name               = "my-cluster-nodes"
  node_count         = "3"
  zone               = "${var.zone}"
  cluster            = "${google_container_cluster.cluster.name}"
  node_config {
    preemptible      = false
    machine_type     = "n1-standard-4"

    oauth_scopes     = [
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring",
    ]
  }
  # Delete the default node pool before spinning this one up
  depends_on         = ["null_resource.default_cluster_deleter"]
}

resource "null_resource" "default_cluster_deleter" {
  provisioner "local-exec" {
    command          = <<EOF
      gcloud container node-pools \
  --project my-project \
  --quiet \
  delete default-pool \
  --cluster ${google_container_cluster.cluster.name}
EOF
  }
}
