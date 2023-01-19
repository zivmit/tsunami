locals {
  cluster_name                    = "${var.name}-eks"
  k8s_version                     = var.k8s_version
  base_cidr                       = var.base_cidr
  default_tags                    = { "env" = local.cluster_name }
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  my_ip                           = "${trimspace(data.http.myip.response_body)}/32"
  mngs                            = var.mngs
}


data "http" "myip" {
  url = "https://ifconfig.me/ip"
}