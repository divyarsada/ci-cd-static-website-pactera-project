variable "critical" {
  default = 9
}
variable "warning" {
  default = 7
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
  default = ""
}
variable "type" {
  default = "log alert"
}
variable "priority" {
  default = 5
}