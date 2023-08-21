variable "security_policies" {
  type = map(object({
    enable_adaptive_protection = string
    rule_visibility            = string
    default_rule               = string
    adv_rules = list(object({
      rule_description = string
      rule_action      = string
      rule_priority    = string
      cel_expression   = string
    }))
    basic_rules = list(object({
      rule_description = string
      rule_action      = string
      rule_priority    = string
      src_ip_ranges    = list(string)
    }))
    rate_limit_ban_rules = list(object({
      rule_priority              = string
      src_ip_ranges              = list(string)
      ban_duration_sec           = number
      ban_threshold_count        = number
      ban_threshold_interval_sec = number
      enforce_on_key             = string
      rate_limit_threshold_count = number
      rate_limit_interval_sec    = number
      exceed_action              = string
      conform_action             = string
      rule_description           = string
      preview                    = bool
    }))

  }))
}

variable "project_id" {
  type = string
}