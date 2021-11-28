variable "type" {
  description = "(required) - Synthetics test type (`api` or `browser`)."
  type        = string
  default     = "api"
}
variable "subtype" {
  description = "(optional) - When `type` is `api`, choose from `http`, `ssl`, `tcp` or `dns`. Defaults to `http`."
  type        = string
  default     = "http"
}
variable "url"{
  type = string
  default = ""
}
variable "assertions" {
  description = "(optional) - List of assertions. **Deprecated.** Define `assertion` blocks instead."
  type        = list(map(string))
  default     = null
}

variable "assertion" {
  description = "nested block: NestingList, min items: 0, max items: 0"
  type = set(object(
  {
    type = string
    operator = string
    target = string
  }
  ))
  default = [
    {
      type = "statusCode"
      operator = "is"
      target = "200"
    },
    {
      type = "responseTime"
      operator = "lessThan"
      target = "2000"
    }
  ]
}
variable "locations"{
  description = "(required) - Array of locations used to run the test. Refer to [Datadog documentation](https://docs.datadoghq.com/synthetics/api_test/#request) for available locations (e.g. `aws:eu-central-1`)."
  type        = set(string)
  default     = ["aws:us-east-2"]
}

variable "tick_every" {
  default = 30
}
variable "retry_count" {
  default = 2
}
variable "retry_interval"{
  default = 300
}

variable "name" {
  description = "(required) - Name of Datadog synthetics test."
  type        = string
  default     = ""
}
variable "message" {
  description = "(optional) - A message to include with notifications for this synthetics test. Email notifications can be sent to specific users by using the same `@username` notation as events."
  type        = string
  default     = <<MESSAGE

  {{#is_warning}} Above {{warn_threshold}}. {{/is_warning}}

  {{#is_warning_recovery}}  Recovered below {{warn_threshold}}.  {{/is_warning_recovery}}

  {{#is_alert}} Above {{threshold}}.  {{/is_alert}}

  {{#is_alert_recovery}} Recovered and below {{threshold}}.  {{/is_alert_recovery}}

  {{#is_recovery}}@pagerduty-Datadog-ResourceIncidentTracking  {{/is_recovery}}

  MESSAGE
}
variable "status" {
  default = "live"
}
variable "service_name" {
  description = "(required) - Name of service."
  type        = string
  default     = ""
}

variable "env" {
  default = ""
}
variable "tags" {
  description = "(optional) - A list of tags to associate with your synthetics test. This can help you categorize and filter tests in the manage synthetics page of the UI. Default is an empty list (`[]`)."
  type        = list(string)
  default     = [
    "env:qaext",
    "service:",
    "terraform:true"
  ]
}