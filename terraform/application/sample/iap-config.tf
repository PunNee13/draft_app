 ######## IAP Config ########

data "google_iam_policy" "iap" {
  binding {
    role = "roles/iap.httpsResourceAccessor"
    members = [
      "group:agbg.asg.gcp.sandboxplus.gen-ai-early@accenture.com",        // a google group
       #"user:n.manikkara@accenture.com"       // a particular user

    ]
  }
}

resource "google_iap_web_backend_service_iam_policy" "policy" {
  project             = local.project_id
  web_backend_service = "${local.lb_name}-backend-default"          #### IMPORTANT!!! local.web_backend_service_name = lb_name from the local vars
  policy_data         = data.google_iam_policy.iap.policy_data
  depends_on = [
    module.lb_https
  ]
}

resource "google_iap_web_backend_service_iam_policy" "policy2" {
  project             = local.project_id
  web_backend_service = "${local.lb_name}-backend-middleware"          #### IMPORTANT!!! local.web_backend_service_name = lb_name from the local vars
  policy_data         = data.google_iam_policy.iap.policy_data
  depends_on = [
    module.lb_https
  ]
}
 