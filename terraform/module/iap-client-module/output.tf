output "client_id_out" {
    value = google_iap_client.project_client.client_id
}

output "secret_out" {
    value = google_iap_client.project_client.secret
}