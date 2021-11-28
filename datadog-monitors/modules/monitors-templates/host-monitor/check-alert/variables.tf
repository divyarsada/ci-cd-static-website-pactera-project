variable notify_no_data {
  default = true
}

variable notify_audit {
   default = false
}
variable timeout_h {
  default = 60
}
variable include_tags {
  default = true
}
variable evaluation_delay {
  default = 900
}
variable env {
  default = ""
}
variable service_name {
  default = ""
}
variable "query" {
  default = ""
}
variable "name" {
  default = ""
}
variable "message" {
  default = <<MESSAGE

  {{#is_warning}}  {{/is_warning}}

  {{#is_warning_recovery}}  {{/is_warning_recovery}}

  {{#is_alert}}  {{/is_alert}}

  {{#is_alert_recovery}}  {{/is_alert_recovery}}

  {{#is_recovery}} {{/is_recovery}}

  MESSAGE
}
variable "type" {
  default = "service check"
}
variable "priority" {
  default = 5
}
variable "new_host_delay" {
  default = 300
}