terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

resource "datadog_synthetics_test" "synthetic_monitor"{
  type    = var.type
  subtype = var.subtype

  request_definition {
    method = "GET"
    url    = var.url
  }

  dynamic "assertion" {
    for_each = var.assertion
    content {
      # type - (required) is a type of string
      # operator - (required) is a type of string
      # target - (optional) is a type of string
      type = assertion.value.type
      operator = assertion.value.operator
      target = assertion.value.target
    }
  }

  locations = var.locations

  options_list {
    tick_every = var.tick_every
    retry {
      count    = var.retry_count
      interval = var.retry_interval
    }
  }

  name    = var.name
  message = var.message
  tags    = var.tags
  status  = var.status

}