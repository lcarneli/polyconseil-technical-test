output "vpc_public_ip" {
  value = module.vpc.public_ip
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "rds_database_endpoint" {
  value = module.rds.database_endpoint
}