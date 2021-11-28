#Choose the detection method
variable "type" {
  description = "(required) - The type of the monitor. The mapping from these types to the types found in the Datadog Web UI can be found in the Datadog API [documentation page](https://docs.datadoghq.com/api/v1/monitors/#create-a-monitor). Note: The monitor type cannot be changed after a monitor is created."
  type        = string
  default     = "metric alert"
}
#Define the metric
variable "query" {
  description = "(required) - The monitor query to notify on. Note this is not the same query you see in the UI and the syntax is different depending on the monitor type, please see the [API Reference](https://docs.datadoghq.com/api/v1/monitors/#create-a-monitor) for details. `terraform plan` will validate query contents unless `validate` is set to `false`.\n\n**Note:** APM latency data is now available as Distribution Metrics. Existing monitors have been migrated automatically but all terraformed monitors can still use the existing metrics. We strongly recommend updating monitor definitions to query the new metrics. To learn more, or to see examples of how to update your terraform definitions to utilize the new distribution metrics, see the [detailed doc](https://docs.datadoghq.com/tracing/guide/ddsketch_trace_metrics/)."
  type        = string
  default     = ""
}
#Monitoring Thresholds
variable "warning" {
  default = 70
}
variable "warning_recovery" {
  default = 50
}
variable "critical" {
  default = 100
}
variable "critical_recovery" {
  default = 80
}
variable "notify_no_data" {
  description = "(optional) - A boolean indicating whether this monitor will notify when data stops reporting. Defaults to `false`."
  type        = bool
  default     = false
}
variable "require_full_window" {
  description = "(optional) - A boolean indicating whether this monitor needs a full window of data before it's evaluated.\n\nWe highly recommend you set this to `false` for sparse metrics, otherwise some evaluations will be skipped. Default: `true` for `on average`, `at all times` and `in total` aggregation. `false` otherwise."
  type        = bool
  default     = false
}
variable "notify_audit" {
  description = "(optional) - A boolean indicating whether tagged users will be notified on changes to this monitor. Defaults to `false`."
  type        = bool
  default     = false
}
variable "timeout_h" {
  description = "(optional) - The number of hours of the monitor not reporting data before it will automatically resolve from a triggered state."
  type        = number
  default     = null
}
variable "include_tags" {
  description = "(optional) - A boolean indicating whether notifications from this monitor automatically insert its triggering tags into the title. Defaults to `true`."
  type        = bool
  default     = true
}
variable "evaluation_delay" {
  description = "(optional) - (Only applies to metric alert) Time (in seconds) to delay evaluation, as a non-negative integer.\n\nFor example, if the value is set to `300` (5min), the `timeframe` is set to `last_5m` and the time is 7:00, the monitor will evaluate data from 6:50 to 6:55. This is useful for AWS CloudWatch and other backfilled metrics to ensure the monitor will always have data during evaluation."
  type        = number
  default     = 900
}

variable "new_host_delay" {
  description = "(optional) - Time (in seconds) to allow a host to boot and applications to fully start before starting the evaluation of monitor results. Should be a non negative integer. Defaults to `300`."
  type        = number
  default     = null
}
#Say what's happening
variable "name" {
  description = "(required) - Name of Datadog monitor."
  type        = string
  default     = "AWS Disk Ops: High Disk Write reported"
}
variable "message" {
  description = "(required) - A message to include with notifications for this monitor.\n\nEmail notifications can be sent to specific users by using the same `@username` notation as events."
  type        = string
  default     = <<MESSAGE
  AWS EC2:Disk I/O ops is high

  {{#is_warning}} Warning Triggered for {{host.name}} in {{region.name}} is over {{warn_threshold}}.  {{/is_warning}}

  {{#is_warning_recovery}} {{host.name}} in {{region.name}} has Recovered and is below {{warn_threshold}}.   {{/is_warning_recovery}}

  {{#is_alert}} Alert Triggered for {{host.name}} in {{region.name}} is over {{threshold}}. {{/is_alert}}

  {{#is_alert_recovery}} {{host.name}} in {{region.name}} has Recovered and is below {{threshold}}. {{/is_alert_recovery}}

  {{#is_recovery}} {{/is_recovery}}

  MESSAGE
}
#Define tags
variable "tags" {
  description = "(optional) - A list of tags to associate with your monitor. This can help you categorize and filter monitors in the manage monitors page of the UI. Note: it's not currently possible to filter by these tags when querying via the API"
  type        = set(string)
  default     = null
}
variable "env" {
  default = ""
}
variable "service_name" {
  default = "ec2"
}

variable "priority" {
  description = "(optional) - Integer from 1 (high) to 5 (low) indicating alert severity."
  type        = number
  default     = 4
}

