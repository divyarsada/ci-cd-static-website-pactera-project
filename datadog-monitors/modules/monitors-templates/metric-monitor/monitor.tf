terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}
resource "datadog_monitor" "metric_monitor" {
  # enable_logs_sample - (optional) is a type of bool
  enable_logs_sample = var.enable_logs_sample
  # escalation_message - (optional) is a type of string
  escalation_message = var.escalation_message
  # evaluation_delay - (optional) is a type of number
  evaluation_delay = var.evaluation_delay
  # force_delete - (optional) is a type of bool
  force_delete = var.force_delete
  # groupby_simple_monitor - (optional) is a type of bool
  groupby_simple_monitor = var.groupby_simple_monitor
  # include_tags - (optional) is a type of bool
  include_tags = var.include_tags
  # locked - (optional) is a type of bool
  locked = var.locked
  # message - (required) is a type of string
  message = var.message
  # name - (required) is a type of string
  name = var.name
  # new_host_delay - (optional) is a type of number
  new_host_delay = var.new_host_delay
  # no_data_timeframe - (optional) is a type of number
  no_data_timeframe = var.no_data_timeframe
  # notify_audit - (optional) is a type of bool
  notify_audit = var.notify_audit
  # notify_no_data - (optional) is a type of bool
  notify_no_data = var.notify_no_data
  # priority - (optional) is a type of number
  priority = var.priority
  # query - (required) is a type of string
  query = var.query
  # renotify_interval - (optional) is a type of number
  renotify_interval = var.renotify_interval
  # require_full_window - (optional) is a type of bool
  require_full_window = var.require_full_window
  # restricted_roles - (optional) is a type of set of string
  restricted_roles = var.restricted_roles
  # tags - (optional) is a type of set of string
  tags = var.tags
//  # threshold_windows - (optional) is a type of map of string
//  threshold_windows = var.threshold_windows
//  # thresholds - (optional) is a type of map of string
//  thresholds = var.thresholds
  # timeout_h - (optional) is a type of number
  timeout_h = var.timeout_h
  # type - (required) is a type of string
  type = var.type
  # validate - (optional) is a type of bool
  validate = var.validate

  dynamic "monitor_threshold_windows" {
    for_each = var.monitor_threshold_windows
    content {
      # recovery_window - (optional) is a type of string
      recovery_window = monitor_threshold_windows.value["recovery_window"]
      # trigger_window - (optional) is a type of string
      trigger_window = monitor_threshold_windows.value["trigger_window"]
    }
  }

  dynamic "monitor_thresholds" {
    for_each = var.monitor_thresholds
    content {
      # critical - (optional) is a type of string
      critical = monitor_thresholds.value.critical
      # critical_recovery - (optional) is a type of string
      critical_recovery = monitor_thresholds.value.critical_recovery
      # warning - (optional) is a type of string
      warning = monitor_thresholds.value.warning
      # warning_recovery - (optional) is a type of string
      warning_recovery = monitor_thresholds.value.warning_recovery
    }
  }

}