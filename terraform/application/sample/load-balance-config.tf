/* 
locals {
  project_id  = "your-prj-id"
  region  = "us-central1"
  location = "us-central1"
  cloud_run_role = "roles/run.invoker"
} */



  module "lb_https" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "~> 6.3"
  name    = local.lb_name                       # Define the name in the locals.tf file
  project = local.project_id

  ##### To Use your own SSL Cert - uncomment use_ssl_certificates and ssl_certificates
  #use_ssl_certificates = true
  #ssl_certificates = ["self link of the already existing ssl-cert"] # gcloud compute ssl-certificates describe my-ssl-cert-name --project=projectname

  ssl = true                                    # This creates Google managed Cert
  create_address = false
  address = module.ip_create.ip_address_id_out  # or existing actual  IP address value "xxx.xxx.xxx.xxx"
  managed_ssl_certificate_domains = ["gen-ai-early.sandboxplus.asg.agbg.dev"]
  http_forward                    = true
  https_redirect                  = true
  create_url_map                  = false
  url_map                         = "lb-2-url-map"
  labels                          = { "example-label" = "cloud-run-example" }

  backends = {
    default = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn              = false
      security_policy         = module.cloud_armor.cloud_armor_out["policy"]
      custom_request_headers  = null
      custom_response_headers = null

      # Before enable and configure IAP, api must be enabled
      # execute "gcloud iap oauth-brands list" to see the Brand name
      # and paste that name in the iap-client-config.tf file in the brand attribute

      iap_config = {
        enable               = false
        oauth2_client_id     = "" #module.iap_client.client_id_out 
        oauth2_client_secret = "" #module.iap_client.secret_out 
      }
      log_config = {
        enable      = false
        sample_rate = null
      }
      protocol         = null
      port_name        = null
      compression_mode = null
    },
    
    #### Second Backend ####

    middleware = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg_middleware.id
        }
      ]
      enable_cdn              = false
      security_policy         = module.cloud_armor.cloud_armor_out["policy"] #null #module.cloud_armor.cloud_armor_out["policy"]
      custom_request_headers  = null
      custom_response_headers = null

      # Before enable and configure IAP, api must be enabled
      # execute "gcloud iap oauth-brands list" to see the Brand name
      # and paste that name in the iap-client-config.tf file in the brand attribute

      iap_config = {
        enable               = false
        oauth2_client_id     = "" #module.iap_client.client_id_out 
        oauth2_client_secret = "" #module.iap_client.secret_out 
      }
      log_config = {
        enable      = false
        sample_rate = null
      }
      protocol         = null
      port_name        = null
      compression_mode = null
    }
    }
}

#### NEW URL MAP ####

resource "google_compute_url_map" "urlmap" {
name        = "lb-2-url-map"
  description = "header-based routing example"
  default_service = module.lb_https.backend_services["default"].self_link
  host_rule {
    hosts = ["gen-ai-early.sandboxplus.asg.agbg.dev"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = module.lb_https.backend_services["default"].self_link
    path_rule {
     paths = ["/middleware/*"] 
     service = module.lb_https.backend_services["middleware"].self_link
     route_action  {
        url_rewrite  {
            path_prefix_rewrite = "/"
        }
     }     
    }
  }
}


resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  project               = local.project_id
  name                  = "serverless-neg"
  network_endpoint_type = "SERVERLESS"
  region                = "us-central1"
  cloud_run {
    service = module.cloud_run_app.cloud_run_out
  }
}

resource "google_compute_region_network_endpoint_group" "serverless_neg_middleware" {
  provider              = google-beta
  project               = local.project_id
  name                  = "serverless-neg-middleware"
  network_endpoint_type = "SERVERLESS"
  region                = "us-central1"
  cloud_run {
    service = module.middleware_cloud_run.middleware_cloud_run_out
  }
}