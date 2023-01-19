data "aws_availability_zones" "available" {}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.31.2"

  cluster_name                         = local.cluster_name
  cluster_version                      = local.k8s_version
  subnet_ids                           = module.vpc.private_subnets
  enable_irsa                          = true
  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = local.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = [local.my_ip]
  manage_aws_auth_configmap            = var.manage_aws_auth_configmap
  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = local.mngs

  node_security_group_additional_rules = {
     metrics_server_ingress_4443 = {
      description                   = "Cluster API to metrics server 4443 ingress port"
      protocol                      = "tcp"
      from_port                     = 4443
      to_port                       = 4443
      type                          = "ingress"
      source_cluster_security_group = true
    }
 }

  tags = merge({
    Name               = local.cluster_name
    Kubernetes_Version = local.k8s_version
  }, local.default_tags)

}

data "aws_eks_cluster_auth" "eks_auth" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.eks_auth.token
}