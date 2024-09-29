variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}


variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

