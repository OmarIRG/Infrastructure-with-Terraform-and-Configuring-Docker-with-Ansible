

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB."
  type        = list(string)
}

variable "private_instance_ids" {
  description = "List of private EC2 instance IDs to attach to the ALB."
  type        = list(string)
}

variable "private_instance_ips" {
  description = "List of private EC2 instance IPs."
  type        = list(string)
}

variable "web_server_port" {
  description = "Port where the web server is running on the instances."
  type        = number
  default     = 80  # Default to 80 for HTTP, but you can override if needed
}
