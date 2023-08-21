output "cloud_armor_out" {
     value = {for k in keys(var.security_policies) : k => google_compute_security_policy.policy[k].id} 
}