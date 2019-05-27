terraform {
 backend "gcs" {
   bucket  = "pearwood-terraform-admin"
   prefix  = "grpc-web-hello/terraform/state"
   project = "pearwood-terraform-admin"
 }
}
