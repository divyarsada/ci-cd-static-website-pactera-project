terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

module "no_of_request"{
  source = "../../monitors-templates/metric-monitor"
  #Choose the detection method
  type = var.type

  #Define the metric
  query = "avg(last_1d):anomalies(avg:aws.applicationelb.request_count{*} by {loadbalancername}.as_rate(), 'basic', 5, direction='above', alert_window='last_1h', interval=300, count_default_zero='true') >= 1"

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
    "service:${var.service_name}",
    "terraform:true"
  ]
  priority = var.priority
}
