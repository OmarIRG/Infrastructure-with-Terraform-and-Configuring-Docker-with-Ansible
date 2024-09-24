variable "public_subnet_ids" {
  description = "List of public subnet IDs where the ALB will be created"
  type        = list(string)
}
