variable "datadog_api_key" {
  type        = string
  description = "Datadog API Key"
}

variable "datadog_app_key" {
  type        = string
  description = "Datadog Application Key"
}

variable "env" {
  type        = string
  description = "AWS Env name"
  default     = "test"
}