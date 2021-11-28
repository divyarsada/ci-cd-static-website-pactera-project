terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}
  
# Configure the Datadog provider
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

module "ec2_cpu_utilization" {
  source = "../../modules/ec2/cpu-utilization"
  env = var.env
  service_name = "ec2"
  #cpu
  warning = "30"
  warning_recovery = "40"
  critical = "20"
  critical_recovery = "25"
}

module "ec2_disk_utilization" {
  source = "../../modules/ec2/disk-utilization"
  env = var.env
  service_name = "ec2"
  #cpu
  warning = "40"
  warning_recovery = "50"
  critical = "20"
  critical_recovery = "30"
}

module "ec2_memory_utilization" {
  source = "../../modules/ec2/memory-utilization"
  env = var.env
  service_name = "ec2"
  #cpu
  warning = "0.4"
  warning_recovery = "0.5"
  critical = "0.2"
  critical_recovery = "0.3"
}

module "ec2_disk_read_ops" {
  source = "../../modules/ec2/disk-read-ops"
  env = var.env
  service_name = "ec2"
  #disk
  warning = 70
  warning_recovery = 50
  critical = 100
  critical_recovery = 80
}

module "ec2_disk_write_ops" {
  source = "../../modules/ec2/disk-write-ops"
  env = var.env
  service_name = "ec2"
  #disk
  warning = 70
  warning_recovery = 50
  critical = 100
  critical_recovery = 80
}
module "ec2_network_in" {
  source = "../../modules/ec2/network-in"
  env = var.env
  service_name = "ec2"
  critical = 262144000
  critical_recovery = 209715200
}

module "ec2_network_out" {
  source = "../../modules/ec2/network-out"
  env = var.env
  service_name = "ec2"
  critical = 262144000
  critical_recovery = 209715200
}

module "ec2_status_check" {
  source = "../../modules/ec2/status-check"
  env = var.env
  service_name = "ec2"
}

module "datadog_agent_health_check"{
  source = "../../modules/ec2/datadog-agent-check"
  service_name = "datadog-agent"
  env = "var.env"

}
module "lb_unhealthy_host_count" {
  source = "../../modules/loadbalancers/unhealthy-host-count"
  env = var.env
  service_name = "lb"
  #lb_unhealthy_host_count
  warning = 4
  warning_recovery = 3
  critical = 6
  critical_recovery = 5
  priority = 4
}

module "lb_5xx_errors" {
  source = "../../modules/loadbalancers/5xx-error"
  env = var.env
  service_name = "lb"
  warning = 10
  warning_recovery = 9
  critical = 20
  critical_recovery = 15
  priority = 4
}


module "lb_4xx_errors" {
  source = "../../modules/loadbalancers/4xx-error"
  env = var.env
  service_name = "lb"
  warning = 10
  warning_recovery = 9
  critical = 20
  critical_recovery = 15
  priority = 4
}

module "lb_backend_5xx_errors" {
  source = "../../modules/loadbalancers/httpcode-backend-5xx"
  env = var.env
  service_name = "lb"
  warning = 10
  warning_recovery = 9
  critical = 20
  critical_recovery = 15
  priority = 4
}


module "lb_request_count" {
  source = "../../modules/loadbalancers/request-count"
  env = var.env
  service_name = "lb"
  type = "query alert"
  priority = 4
}

module "nat_connections" {
  source = "../../modules/vpc/nat-gateways/connections-established-attempted"
  env = var.env
  service_name = "nat"
  critical = 3
  critical_recovery = 2.5
  priority = 4
}
module "nat_packet_drop" {
  source = "../../modules/vpc/nat-gateways/packet-drop-count"
  env = var.env
  service_name = "nat"
  critical = 5
  priority = 4
}
module "nat_packet_received" {
  source = "../../modules/vpc/nat-gateways/packets-received"
  env = var.env
  service_name = "nat"
  critical = 3
  critical_recovery = 2
  priority = 4
}
module "nat_packet_sent" {
  source = "../../modules/vpc/nat-gateways/packets-sent"
  env = var.env
  service_name = "nat"
  critical = 3
  critical_recovery = 2
  priority = 4
  
}

module "static_web_app_health_check" {
  source = "../../modules/endpoint-availability"
  env = var.env
  service_name = "static-web-app"
  name = "static web app health check failed"
  type = "api"
  subtype ="http"
  locations = ["aws:us-east-2"]
  tick_every = 30
  assertion = [
    {
      type = "statusCode"
      operator = "is"
      target = "200"
    },
    {
      type = "responseTime"
      operator ="lessThan"
      target = "2000"
    }
  ]
  status = "live"
  url = "http://mysta-WebAp-160XTP67TIB53-193931316.us-east-1.elb.amazonaws.com:80"
  message = <<MESSAGE
  application health check failed
  {{#is_alert}}   {{/is_alert}}
  {{#is_alert_recovery}} {{/is_alert_recovery}}
  MESSAGE
  tags = [
    "service:static-webapp",
    "terraform:true"
  ]
}