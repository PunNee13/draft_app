resource "google_compute_global_address" "static_ip" {
  name          = var.ip.name
  project       = var.ip.project_id
  address_type  = var.ip.address_type
  description   = var.ip.description
}