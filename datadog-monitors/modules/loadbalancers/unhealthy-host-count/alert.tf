terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

module "unhealthy_host_count" {
  source = "../../monitors-templates/metric-monitor"
  #Choose the detection method
  type = var.type

  #Define the metric
  query = "avg(last_10m):avg:aws.applicationelb.un_healthy_host_count.maximum{*} by {loadbalancername} >= ${var.critical}"

  #Set alert conditions
  monitor_thresholds = [
  {
    critical          = var.critical
    critical_recovery = var.critical_recovery
    warning           = var.warning
    warning_recovery  = var.warning_recovery
  }
  ]
  notify_no_data = var.notify_no_data
  require_full_window = var.require_full_window
  notify_audit = var.notify_audit
  timeout_h = var.timeout_h
  include_tags = var.include_tags
  evaluation_delay = var.evaluation_delay

  #Say what's happening
  name = var.name
  message = var.message
  tags = [
    "env:${var.env}",
    "service:${var.service_name}",
    "terraform:true"
  ]
  priority = var.priority
}
