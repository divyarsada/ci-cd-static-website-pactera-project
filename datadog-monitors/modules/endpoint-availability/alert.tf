terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}
# Create a new Datadog Synthetics API test on
module "endpoint_health_check" {
  source = "../monitors-templates/synthetic-monitor"
  type   = var.type
  subtype = var.subtype
  url = var.url
  assertion = var.assertion
  locations = var.locations
  tick_every = var.tick_every
  retry_count = var.retry_count
  retry_interval = var.retry_interval
  name    = var.name
  status = var.status
  tags = var.tags
  message = var.message
}