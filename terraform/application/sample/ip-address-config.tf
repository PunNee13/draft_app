module "ip_create" {
    source = "./ip-address-module"
    ip = {
        name            = "genai-ip-global"
        project_id      = local.project_id
        address_type    = "EXTERNAL"
    }
}