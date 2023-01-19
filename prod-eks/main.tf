locals {
  region = "eu-west-2"
  env    = "prod"
  read_write_access_arns = ["arn:aws:iam::049313592332:user/ziv"]
}

module "prod" {
  source                            = "../terraform-aws-eks-module/"
  name                              = "prod"
  base_cidr                         = "10.100"
  region                            = local.region
  cluster_endpoint_public_access    = true
  manage_aws_auth_configmap         = true
  mngs = {
    workers-1 = {
      name                            = "workers-1"
      instance_types                  = ["t2.medium"]
      max_size                        = 3
      min_size                        = 1
      on_demand_base                  = 1
      on_demand_percentage_above_base = 0
    }
  }
}

provider "aws" {
  region = local.region
}

terraform {
  backend "local" {
    path = "../tf-states/prod-cluster.tfstate"
  }
}