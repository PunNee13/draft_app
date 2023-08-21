
module "cloud_armor" {
  source = "./cloud-armor-module"
  project_id        = local.project_id
  security_policies = {
    "policy" = {
        adv_rules = [
        {
          cel_expression   = "'[CN,RU]'.contains(origin.region_code)"
          rule_action      = "deny(403)"
          rule_description = "geo-block"
          rule_priority    = "1000"
        } 
        /* {
          cel_expression   = <<EOF
        evaluatePreconfiguredExpr('sqli-stable', ['owasp-crs-v030001-id942110-sqli',
  'owasp-crs-v030301-id942120-sqli',
  'owasp-crs-v030301-id942130-sqli',
  'owasp-crs-v030301-id942150-sqli',
  'owasp-crs-v030301-id942180-sqli',
  'owasp-crs-v030301-id942200-sqli',
  'owasp-crs-v030301-id942210-sqli',
  'owasp-crs-v030301-id942260-sqli',
  'owasp-crs-v030301-id942300-sqli',
  'owasp-crs-v030301-id942310-sqli',
  'owasp-crs-v030301-id942330-sqli',
  'owasp-crs-v030301-id942340-sqli',
  'owasp-crs-v030301-id942361-sqli',
  'owasp-crs-v030301-id942370-sqli',
  'owasp-crs-v030301-id942380-sqli',
  'owasp-crs-v030301-id942390-sqli',
  'owasp-crs-v030301-id942400-sqli',
  'owasp-crs-v030301-id942410-sqli',
  'owasp-crs-v030301-id942470-sqli',
  'owasp-crs-v030301-id942480-sqli',
  'owasp-crs-v030301-id942430-sqli',
  'owasp-crs-v030301-id942440-sqli',
  'owasp-crs-v030301-id942450-sqli',
  'owasp-crs-v030301-id942510-sqli',
  'owasp-crs-v030301-id942251-sqli',
  'owasp-crs-v030301-id942490-sqli',
  'owasp-crs-v030301-id942420-sqli',
  'owasp-crs-v030301-id942431-sqli',
  'owasp-crs-v030301-id942460-sqli',
  'owasp-crs-v030301-id942511-sqli',
  'owasp-crs-v030301-id942421-sqli',
  'owasp-crs-v030301-id942432-sqli'
        ])
        EOF
          rule_action      = "deny(403)"
          rule_description = "SQL injection"
          rule_priority    = "1010"
        },
        {
          cel_expression   = <<EOF
        evaluatePreconfiguredExpr('xss-stable', ['owasp-crs-v030001-id941150-xss',
        'owasp-crs-v030301-id941320-xss',
        'owasp-crs-v030301-id941330-xss',
        'owasp-crs-v030301-id941340-xss',
        'owasp-crs-v030301-id941380-xss'
        ])
        EOF
          rule_action      = "deny(403)"
          rule_description = "Cross-site scripting"
          rule_priority    = "1020"
        },
        {
          cel_expression   = "evaluatePreconfiguredExpr('lfi-stable')"
          rule_action      = "deny(403)"
          rule_description = "Local file inclusion"
          rule_priority    = "1030"
        },
        {
          cel_expression   = "evaluatePreconfiguredExpr('rfi-stable')"
          rule_action      = "deny(403)"
          rule_description = "Remote file inclusion"
          rule_priority    = "1040"
        },
        {
          cel_expression   = "evaluatePreconfiguredExpr('rce-stable',  ['owasp-crs-v030001-id932100-rce', 'owasp-crs-v030001-id932115-rce', 'owasp-crs-v030001-id932110-rce', 'owasp-crs-v030001-id932130-rce'])"
          rule_action      = "deny(403)"
          rule_description = "Remote code execution"
          rule_priority    = "1050"
        },
        {
          cel_expression   = "evaluatePreconfiguredExpr('scannerdetection-stable')"
          rule_action      = "deny(403)"
          rule_description = "Scanner detection"
          rule_priority    = "1060"
        },
        {
          cel_expression   = "evaluatePreconfiguredExpr('protocolattack-stable',['owasp-crs-v030001-id921170-protocolattack', 'owasp-crs-v030001-id921130-protocolattack', 'owasp-crs-v030001-id921150-protocolattack', 'owasp-crs-v030001-id921120-protocolattack'])"
          rule_action      = "deny(403)"
          rule_description = "Protocol attack"
          rule_priority    = "1070"
        },
        {
          cel_expression   = "evaluatePreconfiguredExpr('php-stable', ['owasp-crs-v030001-id933100-php', 'owasp-crs-v030001-id933151-php', 'owasp-crs-v030001-id933131-php', 'owasp-crs-v030001-id933161-php', 'owasp-crs-v030001-id933111-php'])"
          rule_action      = "deny(403)"
          rule_description = "PHP injection attack"
          rule_priority    = "1080"
        },
        {
          cel_expression   = "evaluatePreconfiguredExpr('sessionfixation-stable')"
          rule_action      = "deny(403)"
          rule_description = "Session fixation attack"
          rule_priority    = "1090"
        },
        {
          cel_expression   = "evaluatePreconfiguredExpr('cve-canary', ['owasp-crs-v030001-id244228-cve','owasp-crs-v030001-id344228-cve'])"
          rule_action      = "deny(403)"
          rule_description = "Newly discovered vulnerabilities - Log4j vulnerability"
          rule_priority    = "1100"
        },
        {
          cel_expression   = "evaluatePreconfiguredExpr('methodenforcement-v33-stable')"
          rule_action      = "deny(403)"
          rule_description = "Method enforcement"
          rule_priority    = "1110"
        }, */ 
      ]
      basic_rules = [{
        rule_action      = "allow"
        rule_description = "IP based rule"
        rule_priority    = "12000"
        src_ip_ranges    = ["0.0.0.0/0"]
      }, ]
      default_rule               = "allow"
      enable_adaptive_protection = true
      rate_limit_ban_rules = [{
        ban_duration_sec           = 600
        ban_threshold_count        = 10000
        ban_threshold_interval_sec = 120
        conform_action             = "allow"
        enforce_on_key             = "ALL"
        exceed_action              = "deny(429)"
        preview                    = false
        rate_limit_threshold_count = 4000
        rate_limit_interval_sec    = 60
        rule_description           = "rate-limiting"
        rule_priority              = "14000"
        src_ip_ranges              = ["*"]
      }]
      rule_visibility = "STANDARD"
    }
  }
}
