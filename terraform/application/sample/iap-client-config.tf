module "iap_client" {
    source = "./iap-client-module"
    iap_client = {
        brand           = "projects/765331771100/brands/765331771100" # Paste resault of the name from the "gcloud iap oauth-brands list" command
        desiplay_name   = "GenAI-clinet-id"
        
    }
}