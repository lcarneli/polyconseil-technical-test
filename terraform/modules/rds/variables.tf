variable "customer_name" {
  description = "Name of the customer."
  type        = string
}

variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs."
  type        = list(string)
}

variable "instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes."
  type        = number
}

variable "engine" {
  description = "The database engine to use."
  type        = string
}

variable "engine_version" {
  description = "The engine version to use."
  type        = string
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
}

variable "username" {
  description = "Username for the master DB user."
  type        = string
}

variable "password" {
  description = "Password for the master DB user."
  type        = string
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "security_groups" {
  description = "List of security groups."
  type        = list(string)
}