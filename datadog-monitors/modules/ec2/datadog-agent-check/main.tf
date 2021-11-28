terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}
module "datadog_agent_health_check" {
  source = "../../monitors-templates/host-monitor/check-alert"
  #Pick hosts by name or tag
  query = "\"datadog.agent.up\".over('env:test').by('host').last(4).count_by_status()"

  name = var.name
  type = var.type
  message = var.message

  notify_no_data = var.notify_no_data
  new_host_delay = var.new_host_delay
  notify_audit = var.notify_audit
  #timeout_h = 60
  include_tags = var.include_tags
  priority = var.priority
  service_name = var.service_name
  env = var.env
}
