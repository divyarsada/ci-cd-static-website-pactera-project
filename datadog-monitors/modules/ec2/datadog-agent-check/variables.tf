#Choose the detection method
variable "type" {
  default = "service check"
}
#Define the metric
variable "query" {
  default = ""
}

variable "notify_no_data" {
  default = true
}
variable "require_full_window" {
   default = false
}
variable "notify_audit" {
   default = false
}
variable "timeout_h" {
  default = 60
}
variable "include_tags" {
  default = true
}
variable "evaluation_delay" {
  default = 900
}
#Say what's happening
variable "name" {
  default = "AWS Hosts: Datadog agent health check failed"
}
variable "message" {
  default = <<MESSAGE
  {{#is_warning}} Warning Triggered for {{host.name}} in {{host.region}}  {{/is_warning}}

  {{#is_warning_recovery}} {{host.name}} in {{host.region}}    {{/is_warning_recovery}}

  {{#is_alert}} Alert Triggered for {{host.name}} in {{host.region}}g {{/is_alert}}

  {{#is_alert_recovery}} {{host.name}} in {{host.region}} Has Recovered  {{/is_alert_recovery}}
  {{#is_recovery}} {{/is_recovery}}
  MESSAGE
}

variable "priority" {
  default = 5
}
#Define tags
variable "env" {
  default = ""
}
variable "service_name" {
  default = "datadog-agent"
}
variable "new_host_delay" {
  default = 300
}

