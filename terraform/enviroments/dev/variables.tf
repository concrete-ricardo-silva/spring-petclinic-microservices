variable "linux_admin_username" {
    type        = "string"
    description = "User name for authentication to the Kubernetes linux agent virtual machines in the cluster."
}

variable "linux_admin_password" {
    type ="string"
    description = "The password for the Linux admin account."
}

variable "cluster_name" {
    type = "string"
    description = "Cluster name for the GCP Cluster."
}

variable "env" {
    type = "string"
    description = "Environment name for the GCP Cluster."
}

variable "name" {
    type = "string"
    description = "Resource name for the GCP Cluster."
}

variable "cluster_ci_name" {
    type = "string"
    description = "Resource name for CI k8s Cluster."
}
variable "zone" {
    type = "string"
    description = "Zone for the GCP Cluster."
}
