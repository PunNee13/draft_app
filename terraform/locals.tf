locals {
  project_id                = "gaie-0008052023"
  region                    = "us-central1"
  location                  = "us-central1"
  cloud_run_role            = "roles/run.invoker"
  #  web_backend_service_name  = "gen-ai-lb-backend-default"
  lb_name                   = "gen-ai-lb-1" 
}