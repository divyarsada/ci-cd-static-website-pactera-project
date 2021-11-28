variable "enable_logs_sample" {
  description = "(optional) - A boolean indicating whether or not to include a list of log values which triggered the alert. This is only used by log monitors. Defaults to `false`."
  type        = bool
  default     = null
}

variable "escalation_message" {
  description = "(optional) - A message to include with a re-notification. Supports the `@username` notification allowed elsewhere."
  type        = string
  default     = null
}

variable "evaluation_delay" {
  description = "(optional) - (Only applies to metric alert) Time (in seconds) to delay evaluation, as a non-negative integer.\n\nFor example, if the value is set to `300` (5min), the `timeframe` is set to `last_5m` and the time is 7:00, the monitor will evaluate data from 6:50 to 6:55. This is useful for AWS CloudWatch and other backfilled metrics to ensure the monitor will always have data during evaluation."
  type        = number
  default     = null
}

variable "force_delete" {
  description = "(optional) - A boolean indicating whether this monitor can be deleted even if it’s referenced by other resources (e.g. SLO, composite monitor)."
  type        = bool
  default     = null
}

variable "groupby_simple_monitor" {
  description = "(optional) - Whether or not to trigger one alert if any source breaches a threshold. This is only used by log monitors. Defaults to `false`."
  type        = bool
  default     = null
}

variable "include_tags" {
  description = "(optional) - A boolean indicating whether notifications from this monitor automatically insert its triggering tags into the title. Defaults to `true`."
  type        = bool
  default     = null
}

variable "locked" {
  description = "(optional) - A boolean indicating whether changes to to this monitor should be restricted to the creator or admins. Defaults to `false`."
  type        = bool
  default     = null
}

variable "message" {
  description = "(required) - A message to include with notifications for this monitor.\n\nEmail notifications can be sent to specific users by using the same `@username` notation as events."
  type        = string
}

variable "name" {
  description = "(required) - Name of Datadog monitor."
  type        = string
}

variable "new_host_delay" {
  description = "(optional) - Time (in seconds) to allow a host to boot and applications to fully start before starting the evaluation of monitor results. Should be a non negative integer. Defaults to `300`."
  type        = number
  default     = null
}

variable "no_data_timeframe" {
  description = "(optional) - The number of minutes before a monitor will notify when data stops reporting. Provider defaults to 10 minutes.\n\nWe recommend at least 2x the monitor timeframe for metric alerts or 2 minutes for service checks."
  type        = number
  default     = null
}

variable "notify_audit" {
  description = "(optional) - A boolean indicating whether tagged users will be notified on changes to this monitor. Defaults to `false`."
  type        = bool
  default     = null
}

variable "notify_no_data" {
  description = "(optional) - A boolean indicating whether this monitor will notify when data stops reporting. Defaults to `false`."
  type        = bool
  default     = null
}

variable "priority" {
  description = "(optional) - Integer from 1 (high) to 5 (low) indicating alert severity."
  type        = number
  default     = null
}

variable "query" {
  description = "(required) - The monitor query to notify on. Note this is not the same query you see in the UI and the syntax is different depending on the monitor type, please see the [API Reference](https://docs.datadoghq.com/api/v1/monitors/#create-a-monitor) for details. `terraform plan` will validate query contents unless `validate` is set to `false`.\n\n**Note:** APM latency data is now available as Distribution Metrics. Existing monitors have been migrated automatically but all terraformed monitors can still use the existing metrics. We strongly recommend updating monitor definitions to query the new metrics. To learn more, or to see examples of how to update your terraform definitions to utilize the new distribution metrics, see the [detailed doc](https://docs.datadoghq.com/tracing/guide/ddsketch_trace_metrics/)."
  type        = string
}

variable "renotify_interval" {
  description = "(optional) - The number of minutes after the last notification before a monitor will re-notify on the current status. It will only re-notify if it's not resolved."
  type        = number
  default     = null
}

variable "require_full_window" {
  description = "(optional) - A boolean indicating whether this monitor needs a full window of data before it's evaluated.\n\nWe highly recommend you set this to `false` for sparse metrics, otherwise some evaluations will be skipped. Default: `true` for `on average`, `at all times` and `in total` aggregation. `false` otherwise."
  type        = bool
  default     = null
}

variable "restricted_roles" {
  description = "(optional)"
  type        = set(string)
  default     = null
}

variable "silenced" {
  description = "(optional) - Each scope will be muted until the given POSIX timestamp or forever if the value is `0`. Use `-1` if you want to unmute the scope. Deprecated: the silenced parameter is being deprecated in favor of the downtime resource. This will be removed in the next major version of the Terraform Provider. **Deprecated.** Use the Downtime resource instead."
  type        = map(number)
  default     = null
}

variable "tags" {
  description = "(optional) - A list of tags to associate with your monitor. This can help you categorize and filter monitors in the manage monitors page of the UI. Note: it's not currently possible to filter by these tags when querying via the API"
  type        = set(string)
  default     = null
}

variable "threshold_windows" {
  description = "(optional) - A mapping containing `recovery_window` and `trigger_window` values, e.g. `last_15m`. Can only be used for, and are required for, anomaly monitors. **Deprecated.** Define `monitor_threshold_windows` list with one element instead."
  type        = map(string)
  default     = null
}

variable "thresholds" {
  description = "(optional) - Alert thresholds of the monitor. **Deprecated.** Define `monitor_thresholds` list with one element instead."
  type        = map(string)
  default     = null
}

variable "timeout_h" {
  description = "(optional) - The number of hours of the monitor not reporting data before it will automatically resolve from a triggered state."
  type        = number
  default     = null
}

variable "type" {
  description = "(required) - The type of the monitor. The mapping from these types to the types found in the Datadog Web UI can be found in the Datadog API [documentation page](https://docs.datadoghq.com/api/v1/monitors/#create-a-monitor). Note: The monitor type cannot be changed after a monitor is created."
  type        = string
}

variable "validate" {
  description = "(optional) - If set to `false`, skip the validation call done during plan."
  type        = bool
  default     = null
}

variable "monitor_threshold_windows" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      recovery_window = string
      trigger_window  = string
    }
  ))
  default = []
}

variable "monitor_thresholds" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      critical          = string
      critical_recovery = string
      warning           = string
      warning_recovery  = string
    }
  ))
  default = []
}