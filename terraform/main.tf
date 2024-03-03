module "vpc" {
  source = "./modules/vpc"

  availability_zones = var.vpc_availability_zones
  cidr_bits          = var.vpc_cidr_bits
  cidr_block         = var.vpc_cidr_block
  customer_name      = var.customer_name
  project_name       = var.project_name
}

module "eks" {
  source = "./modules/eks"

  cluster_public_access_cidrs = var.eks_cluster_public_access_cidrs
  cluster_subnet_ids          = flatten([module.vpc.public_subnet_ids, module.vpc.private_subnet_ids])
  cluster_version             = var.eks_cluster_version
  customer_name               = var.customer_name
  ebs_csi_driver_version      = var.eks_ebs_csi_driver_version
  node_group_ami_type         = var.eks_node_group_ami_type
  node_group_capacity_type    = var.eks_node_group_capacity_type
  node_group_desired_size     = var.eks_node_group_desired_size
  node_group_disk_size        = var.eks_node_group_disk_size
  node_group_instance_types   = var.eks_node_group_instance_types
  node_group_max_size         = var.eks_node_group_max_size
  node_group_min_size         = var.eks_node_group_min_size
  node_group_subnet_ids       = module.vpc.private_subnet_ids
  project_name                = var.project_name
  vpc_id                      = module.vpc.vpc_id

  depends_on = [module.vpc]
}

module "rds" {
  source = "./modules/rds"

  allocated_storage   = var.rds_allocated_storage
  customer_name       = var.customer_name
  db_name             = var.rds_db_name
  engine              = var.rds_engine
  engine_version      = var.rds_engine_version
  instance_class      = var.rds_instance_class
  password            = var.rds_password
  project_name        = var.project_name
  security_groups     = [module.eks.cluster_security_group_id]
  skip_final_snapshot = var.rds_skip_final_snapshot
  subnet_ids          = module.vpc.private_subnet_ids
  username            = var.rds_username
  vpc_id              = module.vpc.vpc_id

  depends_on = [module.vpc]
}
