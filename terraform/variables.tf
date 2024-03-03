variable "customer_name" {
  description = "Name of the customer."
  type        = string
}

variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "vpc_availability_zones" {
  description = "The number of availability zones."
  type        = number
}

variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
}

variable "vpc_cidr_bits" {
  description = "The number of additional bits with which to extend the CIDR block."
  type        = number
}

variable "eks_cluster_version" {
  description = "Desired Kubernetes master version."
  type        = number
}

variable "eks_cluster_public_access_cidrs" {
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled."
  type        = list(string)
}

variable "eks_node_group_ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group."
  type        = string
}

variable "eks_node_group_capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. "
  type        = string
}

variable "eks_node_group_instance_types" {
  description = " List of instance types associated with the EKS Node Group."
  type        = list(string)
}

variable "eks_node_group_disk_size" {
  description = "Disk size in GiB for worker nodes."
  type        = number
}

variable "eks_node_group_desired_size" {
  description = "Desired number of worker nodes."
  type        = number
}

variable "eks_node_group_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
}

variable "eks_node_group_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
}

variable "eks_ebs_csi_driver_version" {
  description = "The version of the EKS add-on."
  type        = string
}

variable "rds_instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
}

variable "rds_allocated_storage" {
  description = "The allocated storage in gigabytes."
  type        = number
}

variable "rds_engine" {
  description = "The database engine to use."
  type        = string
}

variable "rds_engine_version" {
  description = "The engine version to use."
  type        = string
}

variable "rds_db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
}

variable "rds_username" {
  description = "Username for the master DB user."
  type        = string
}

variable "rds_password" {
  description = "Password for the master DB user."
  type        = string
}

variable "rds_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
  type        = string
}