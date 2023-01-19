module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = "${local.cluster_name}-vpc"
  cidr = "${local.base_cidr}.0.0/16"

  azs                       = data.aws_availability_zones.available.names
  private_subnets           = ["${local.base_cidr}.1.0/24", "${local.base_cidr}.2.0/24", "${local.base_cidr}.3.0/24"]
  public_subnets            = ["${local.base_cidr}.4.0/24", "${local.base_cidr}.5.0/24", "${local.base_cidr}.6.0/24"]
  enable_nat_gateway        = true
  single_nat_gateway        = true
  enable_dns_hostnames      = true
}
