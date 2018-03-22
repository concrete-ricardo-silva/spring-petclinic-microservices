# create cluster
module "gcloud-kubernetes" {
  source             = "../../modules/kubernetes-cluster"
  name               = "${var.name}"
  description        = "${var.description}"
  zone               = "${var.zone}"
  initial_node_count = "${var.initial_node_count}"
}
