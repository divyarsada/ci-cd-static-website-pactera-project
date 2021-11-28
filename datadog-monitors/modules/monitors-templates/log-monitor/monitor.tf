terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}
resource "datadog_monitor" "log_monitor" {
  name = var.name
  type = "log alert"
  message = var.message

  query = var.query
  monitor_thresholds {
    warning = var.warning
    critical = var.critical
  }

  include_tags = true
  evaluation_delay = 900
  priority = var.priority
  tags = [
    "service:${var.service_name}",
    "terraform:true"
  ]
}