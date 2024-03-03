variable "customer_name" {
  description = "Name of the customer."
  type        = string
}

variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "cluster_version" {
  description = "Desired Kubernetes master version."
  type        = number
}

variable "cluster_subnet_ids" {
  description = "List of subnet IDs."
  type        = list(string)
}

variable "cluster_public_access_cidrs" {
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled."
  type        = list(string)
}

variable "node_group_subnet_ids" {
  description = "Identifiers of EC2 Subnets to associate with the EKS Node Group."
  type        = list(string)
}

variable "node_group_ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group."
  type        = string
}

variable "node_group_capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. "
  type        = string
}

variable "node_group_instance_types" {
  description = "List of instance types associated with the EKS Node Group."
  type        = list(string)
}

variable "node_group_disk_size" {
  description = "Disk size in GiB for worker nodes."
  type        = number
}

variable "node_group_desired_size" {
  description = "Desired number of worker nodes."
  type        = number
}

variable "node_group_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
}

variable "node_group_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
}

variable "ebs_csi_driver_version" {
  description = "The version of the EKS add-on."
  type        = string
}