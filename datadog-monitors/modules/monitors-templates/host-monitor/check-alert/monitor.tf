terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}
resource "datadog_monitor" "host_monitor" {
  name = var.name
  type = var.type
  message = var.message

  query = var.query
  notify_no_data = var.notify_no_data
  new_host_delay = var.new_host_delay
  notify_audit = var.notify_audit
  #timeout_h = var.timeout_h
  include_tags = var.include_tags
  priority = var.priority
  tags = [
    "service:${var.service_name}",
    "terraform:true"
  ]
}