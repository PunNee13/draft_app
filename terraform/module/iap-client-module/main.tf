resource "google_iap_client" "project_client" {
  display_name = var.iap_client.desiplay_name
  brand        =  var.iap_client.brand
}