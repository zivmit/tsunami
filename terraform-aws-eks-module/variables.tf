variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "k8s_version" {
  type    = string
  default = "1.23"
}

variable "name" {
  type = string
}

variable "base_cidr" {
  type = string
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = false
}

variable "manage_aws_auth_configmap" {
  type    = bool
  default = false
}

variable "mngs" {
  type = any
}

