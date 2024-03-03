variable "customer_name" {
  description = "Name of the customer."
  type        = string
}

variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "availability_zones" {
  description = "The number of availability zones."
  type        = number
}

variable "cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
}

variable "cidr_bits" {
  description = "The number of additional bits with which to extend the CIDR block."
  type        = number
}