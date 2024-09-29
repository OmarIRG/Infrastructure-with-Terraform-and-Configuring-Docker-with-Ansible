variable "vpc_id" {
  description = "The ID of the VPC where the subnets will be created"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones in which to create subnets"
  type        = list(string)
}
