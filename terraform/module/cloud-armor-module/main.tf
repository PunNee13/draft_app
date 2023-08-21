resource "google_compute_security_policy" "policy" {
  provider = google-beta
  for_each = var.security_policies
  project  = var.project_id
  name     = each.key
  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable          = each.value.enable_adaptive_protection
      rule_visibility = each.value.rule_visibility
    }
  }

  dynamic "rule" {
    for_each = each.value.adv_rules
    content {
      description = rule.value.rule_description
      action      = rule.value.rule_action
      priority    = rule.value.rule_priority
      match {
        expr {
          expression = rule.value.cel_expression
        }
      }
    }

  }

  dynamic "rule" {
    for_each = each.value.basic_rules
    content {
      description = rule.value.rule_description
      action      = rule.value.rule_action
      priority    = rule.value.rule_priority
      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = rule.value.src_ip_ranges
        }
      }
    }
  }

  dynamic "rule" {
    for_each = each.value.rate_limit_ban_rules
    content {
      action   = "rate_based_ban"
      priority = rule.value.rule_priority
      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = rule.value.src_ip_ranges
        }
      }
      rate_limit_options {
        ban_duration_sec = rule.value.ban_duration_sec
        ban_threshold {
          count        = rule.value.ban_threshold_count
          interval_sec = rule.value.ban_threshold_interval_sec
        }
        enforce_on_key = rule.value.enforce_on_key
        rate_limit_threshold {
          count        = rule.value.rate_limit_threshold_count
          interval_sec = rule.value.rate_limit_interval_sec
        }
        exceed_action  = rule.value.exceed_action
        conform_action = rule.value.conform_action
      }
      description = rule.value.rule_description
      preview     = rule.value.preview
    }
  }

  rule {
    action   = each.value.default_rule
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }


}