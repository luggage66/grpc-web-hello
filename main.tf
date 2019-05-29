variable "project_name" {}
variable "billing_account" {}
variable "org_id" {}
variable "region" {}

provider "google" {
 region = "${var.region}"
}

provider "kubernetes" {
  config_context_cluster   = "minikube"
}

resource "random_id" "id" {
 byte_length = 4
 prefix      = "${var.project_name}-"
}

resource "google_project" "project" {
 name            = "${var.project_name}"
 project_id      = "${random_id.id.hex}"
 billing_account = "${var.billing_account}"
 org_id          = "${var.org_id}"
}

resource "google_project_services" "project" {
    project = "${google_project.project.project_id}"
    services = [
        "compute.googleapis.com",
        "oslogin.googleapis.com",
        "containerregistry.googleapis.com",
        "pubsub.googleapis.com",
        "storage-api.googleapis.com"
    ]
}

resource "google_service_account" "minikube_sa" {
  account_id   = "laptop2-minikube"
  display_name = "Minikube service account"
  project = "${google_project.project.project_id}"
}

resource "google_service_account_key" "googleminikubekey" {
  service_account_id = "${google_service_account.minikube_sa.name}"
}

resource "kubernetes_service_account" "default" {
  metadata {
    name = "default"
  }
  image_pull_secret {
    name = "docker-config"
  }
}

resource "kubernetes_secret" "google-application-credentials" {
  metadata = {
    name = "google-application-credentials"
  }
  data {
    credentials.json = "${base64decode(google_service_account_key.googleminikubekey.private_key)}"
  }
}

resource "kubernetes_secret" "gcr-pull-key" {
  metadata {
    name = "docker-config"
  }

  data {
    ".dockerconfigjson" = "${jsonencode(
      map(
        "auths", map(
          "https://gcr.io", map(
            "auth", google_service_account_key.googleminikubekey.private_key
          )
        )
      )
    )}"
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "google_project_iam_member" "binding_push_access" {
  project = "${google_project.project.project_id}"
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.minikube_sa.email}"
}

resource "google_project_iam_member" "binding_pull_access" {
  project = "${google_project.project.project_id}"
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.minikube_sa.email}"
}

output "project_id" {
 value = "${google_project.project.project_id}"
}

output "service_account" {
    value = "${google_service_account.minikube_sa.email}"
}

output "service_key" {
    value = "${base64decode(google_service_account_key.googleminikubekey.private_key)}"
}
