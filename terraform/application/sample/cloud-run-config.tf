module "cloud_run_app" {
  source = "./cloud-run-module"
  cloud_run = {
    cloud_run_name       = "frontend-app"
    project              = local.project_id
    region               = local.region
    location             = local.location
    min_instances        = "1"
    max_instances        = "3"
    cpu_limit            = "1000m"
    memory_limit         = "1Gi"
    container_port       = 80                                     # Default is 80         
    cloud_run_role       = local.cloud_run_role
    members              = ["allAuthenticatedUsers"]                           # ["allAuthenticatedUsers"] or ["allUsers"] or ["group:your-group@eyample.com"]
    internal_or_external = "internal-and-cloud-load-balancing"    # For External, type  - "all",  # Internal and LB - "internal-and-cloud-load-balancing" # Internal - "internal"
    container_image      =  "nginx:alpine" 
    service_account_name = "cloud-run-sa@gaie-0008052023.iam.gserviceaccount.com"
    
  }
}

module "middleware_cloud_run" {
  source = "./cloud-run-module"
  cloud_run = {
    cloud_run_name       = "bankendgenai-app"
    project              = local.project_id
    region               = local.region
    location             = local.location
    min_instances        = "1"
    max_instances        = "3"
    cpu_limit            = "1000m"
    memory_limit         = "1Gi"
    container_port       = 80               # Default is 80         
    cloud_run_role       = local.cloud_run_role
    members              = ["allAuthenticatedUsers"]     # ["allAuthenticatedUsers"]  ["allUsers"] ["group:your-group@eyample.com"]
    internal_or_external = "internal-and-cloud-load-balancing"            # For External type  "all"  # Internal and LB - "internal-and-cloud-load-balancing" # Internal - "internal"
    container_image      = "httpd:latest" 
    service_account_name = "cloud-run-sa@gaie-0008052023.iam.gserviceaccount.com"
    
  }
}